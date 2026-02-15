resource "aws_apigatewayv2_api" "this" {
  name          = var.name
  protocol_type = var.protocol_type
  description   = var.description
  tags          = var.tags
}

resource "aws_apigatewayv2_integration" "default" {
  count = var.protocol_type == "HTTP" && var.integration_uri != null ? 1 : 0

  api_id                 = aws_apigatewayv2_api.this.id
  integration_type       = var.integration_type
  integration_uri        = var.integration_uri
  integration_method     = var.integration_method
  payload_format_version = var.payload_format_version
}

resource "aws_apigatewayv2_route" "default" {
  count = var.protocol_type == "HTTP" && var.integration_uri != null && var.route_key != null ? 1 : 0

  api_id    = aws_apigatewayv2_api.this.id
  route_key = var.route_key
  target    = "integrations/${aws_apigatewayv2_integration.default[0].id}"
}

resource "aws_apigatewayv2_stage" "default" {
  count = var.create_default_stage ? 1 : 0

  api_id      = aws_apigatewayv2_api.this.id
  name        = var.stage_name
  auto_deploy = true
  tags        = var.tags
}
