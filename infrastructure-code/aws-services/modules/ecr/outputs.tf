output "repository_url" {
  description = "The URL of the created ECR repository"
  value       = aws_ecr_repository.private_repo.repository_url
}

output "repository_arn" {
  description = "ARN of the ECR repository"
  value       = aws_ecr_repository.private_repo.arn
}
