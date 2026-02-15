output "s3_bucket_id" {
  description = "Bucket name (ID)"
  value       = aws_s3_bucket.this.id
}

output "s3_bucket_arn" {
  description = "Bucket ARN"
  value       = aws_s3_bucket.this.arn
}

output "s3_bucket_bucket_domain_name" {
  description = "Bucket domain name"
  value       = aws_s3_bucket.this.bucket_domain_name
}

output "s3_bucket_bucket_regional_domain_name" {
  description = "Bucket region-specific domain name"
  value       = aws_s3_bucket.this.bucket_regional_domain_name
}
