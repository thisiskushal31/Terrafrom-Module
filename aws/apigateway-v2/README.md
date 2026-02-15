# apigateway-v2

Creates an API Gateway v2 HTTP API (or WebSocket). Optionally one default integration (Lambda or HTTP) and stage. Use for serverless APIs in front of Lambda or HTTP backends.

## Inputs

| Name | Description | Default |
|------|-------------|---------|
| name | API name | required |
| protocol_type | HTTP or WEBSOCKET | HTTP |
| integration_uri | Lambda ARN or HTTP URL for default route | null |
| route_key | Route key for default route | ANY /{proxy+} |
| create_default_stage | Create $default stage | true |
| tags | Tags | {} |

## Outputs

- **api_id**, **api_endpoint**, **execution_arn**, **stage_invoke_url**
