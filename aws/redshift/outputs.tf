output "cluster_id" {
  description = "Cluster identifier"
  value       = aws_redshift_cluster.this.id
}

output "cluster_endpoint" {
  description = "Connection endpoint"
  value       = aws_redshift_cluster.this.endpoint
}

output "cluster_arn" {
  description = "Cluster ARN"
  value       = aws_redshift_cluster.this.arn
}
