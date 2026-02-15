output "cluster_id" {
  description = "EKS cluster ID"
  value       = aws_eks_cluster.cluster.id
}

output "cluster_name" {
  description = "EKS cluster name"
  value       = aws_eks_cluster.cluster.name
}

output "cluster_arn" {
  description = "EKS cluster ARN"
  value       = aws_eks_cluster.cluster.arn
}

output "cluster_endpoint" {
  description = "Cluster API endpoint"
  value       = aws_eks_cluster.cluster.endpoint
  sensitive   = true
}

output "cluster_certificate_authority_data" {
  description = "Base64-encoded CA certificate for the cluster"
  value       = aws_eks_cluster.cluster.certificate_authority[0].data
  sensitive   = true
}

output "cluster_version" {
  description = "Kubernetes version of the cluster"
  value       = aws_eks_cluster.cluster.version
}

output "cluster_iam_role_arn" {
  description = "IAM role ARN used by the EKS cluster"
  value       = aws_iam_role.cluster.arn
}

output "node_iam_role_arn" {
  description = "IAM role ARN used by managed node groups"
  value       = aws_iam_role.node.arn
}

output "oidc_issuer_url" {
  description = "OIDC issuer URL for the cluster (for IRSA / workload identity)"
  value       = aws_eks_cluster.cluster.oidc[0].issuer
}

output "aws_cloud" {
  description = "Cluster details for use by callers"
  value = {
    cluster_name   = aws_eks_cluster.cluster.name
    cluster_arn    = aws_eks_cluster.cluster.arn
    cluster_id     = aws_eks_cluster.cluster.id
  }
}
