output "cluster_arn" {
  description = "MSK cluster ARN"
  value       = aws_msk_cluster.this.arn
}

output "cluster_name" {
  description = "MSK cluster name"
  value       = aws_msk_cluster.this.name
}

output "bootstrap_brokers" {
  description = "Bootstrap broker string (TLS)"
  value       = aws_msk_cluster.this.bootstrap_brokers
  sensitive   = true
}

output "bootstrap_brokers_sasl_iam" {
  description = "Bootstrap brokers with SASL/IAM"
  value       = aws_msk_cluster.this.bootstrap_brokers_sasl_iam
  sensitive   = true
}
