variable "ecr_repo_name" {
  description = "Name of the ECR repository"
  type        = string
}

variable "image_mutability" {
  description = "Whether image tags are mutable or immutable"
  type        = string
}

variable "scan_on_push" {
  description = "Enable image scanning on push"
  type        = bool
}

variable "encryption_type" {
  description = "Type of encryption to use"
  type        = string
}

variable "tags" {
  description = "Tags to assign to the repository"
  type        = map(string)
}
