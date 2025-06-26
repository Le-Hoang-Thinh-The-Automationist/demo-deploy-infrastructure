output "role_arn" {
  description = "IAM Role ARN to use in GitHub Actions"
  value       = aws_iam_role.github_oidc.arn
}
