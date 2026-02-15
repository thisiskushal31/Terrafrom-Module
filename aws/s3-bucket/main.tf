resource "aws_s3_bucket" "this" {
  bucket        = var.bucket_prefix != null ? null : var.bucket
  bucket_prefix = var.bucket_prefix
  force_destroy = var.force_destroy
  tags          = var.tags
}

resource "aws_s3_bucket_versioning" "this" {
  count = try(var.versioning.enabled, false) ? 1 : 0

  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = "Enabled"
  }
}
