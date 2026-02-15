# acm

Creates an ACM certificate (public). Use for ALB, CloudFront, API Gateway HTTPS. Caller creates DNS validation records (Route53 or elsewhere) and optionally aws_acm_certificate_validation.

## Inputs

| Name | Description | Default |
|------|-------------|---------|
| domain_name | Primary domain | required |
| subject_alternative_names | SANs | [] |
| validation_method | DNS or EMAIL | DNS |
| key_algorithm | RSA_2048 or EC_prime256v1 | RSA_2048 |
| tags | Tags | {} |

## Outputs

- **certificate_arn** — Use in ALB/CloudFront/API Gateway
- **domain_validation_options** — For creating validation records
