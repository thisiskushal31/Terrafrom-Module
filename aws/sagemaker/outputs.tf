output "notebook_instance_arn" {
  description = "ARN of the notebook instance"
  value       = aws_sagemaker_notebook_instance.this.arn
}

output "notebook_instance_name" {
  description = "Name of the notebook instance"
  value       = aws_sagemaker_notebook_instance.this.name
}

output "notebook_instance_url" {
  description = "URL to open the Jupyter notebook"
  value       = aws_sagemaker_notebook_instance.this.url
}
