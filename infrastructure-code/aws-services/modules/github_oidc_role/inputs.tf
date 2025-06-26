variable "role_name" {
  description = "IAM role name for GitHub OIDC"
  type        = string
}

variable "github_repo" {
  description = "GitHub repository in format org/repo"
  type        = string
}

variable "allowed_branch" {
  description = "GitHub repository's branch for the OIDC"
  type        = string
}
