/**
 * Single KMS key with optional alias. Equivalent to gcp/kms.
 * Reference: modules-clone/terraform-aws-kms (simplified).
 */

data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}

data "aws_iam_policy_document" "this" {
  statement {
    sid    = "Default"
    effect = "Allow"
    actions = ["kms:*"]
    resources = ["*"]

    principals {
      type        = "AWS"
      identifiers = ["arn:${data.aws_partition.current.partition}:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
  }
}

resource "aws_kms_key" "this" {
  description             = var.description
  deletion_window_in_days = var.deletion_window_in_days
  enable_key_rotation     = var.enable_key_rotation
  policy                  = data.aws_iam_policy_document.this.json

  tags = var.tags
}

resource "aws_kms_alias" "this" {
  count = var.alias != null ? 1 : 0

  name          = startswith(var.alias, "alias/") ? var.alias : "alias/${var.alias}"
  target_key_id = aws_kms_key.this.key_id
}
