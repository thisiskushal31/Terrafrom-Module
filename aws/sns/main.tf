resource "aws_sns_topic" "this" {
  name         = var.fifo_topic ? "${var.name}.fifo" : var.name
  fifo_topic   = var.fifo_topic
  display_name = var.display_name
  tags         = var.tags
}
