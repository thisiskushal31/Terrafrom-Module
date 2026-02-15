resource "aws_cloudwatch_event_rule" "this" {
  name                = var.name
  description        = var.description
  schedule_expression = var.schedule_expression
  event_pattern      = var.event_pattern
  tags               = var.tags
}

resource "aws_cloudwatch_event_target" "this" {
  count = var.target_arn != null ? 1 : 0

  rule      = aws_cloudwatch_event_rule.this.name
  target_id = "default"
  arn       = var.target_arn
}
