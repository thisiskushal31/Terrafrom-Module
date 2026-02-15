output "api_id" {
  description = "API ID"
  value       = aws_apigatewayv2_api.this.id
}

output "api_endpoint" {
  description = "API endpoint (execute-api)"
  value       = aws_apigatewayv2_api.this.api_endpoint
}

output "execution_arn" {
  description = "Execution ARN (for Lambda permission)"
  value       = aws_apigatewayv2_api.this.execution_arn
}

output "stage_invoke_url" {
  description = "Invoke URL of the default stage (when create_default_stage = true)"
  value       = var.create_default_stage ? aws_apigatewayv2_stage.default[0].invoke_url : null
}
