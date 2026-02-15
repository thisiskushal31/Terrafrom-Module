resource "aws_sqs_queue" "this" {
  name                       = var.fifo_queue ? "${var.name}.fifo" : var.name
  fifo_queue                 = var.fifo_queue
  delay_seconds              = var.delay_seconds
  message_retention_seconds  = var.message_retention_seconds
  visibility_timeout_seconds = var.visibility_timeout_seconds
  tags                       = var.tags
}
