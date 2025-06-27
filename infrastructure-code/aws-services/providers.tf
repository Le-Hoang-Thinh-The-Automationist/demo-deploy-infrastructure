terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  required_version = ">= 1.3.0"
}
variable "env_file_path" {
  description = "Path to your custom .env file"
  type        = string
  default     = "./.env"
}

locals {
  # Properly trim newlines and spaces from file content
  raw_lines = split("\n", trim(file(var.env_file_path), "\n\r "))

  env_map = {
    for line in local.raw_lines :
    trim(split("=", line)[0], "\n\r ") => trim(join("=", slice(split("=", line), 1, length(split("=", line)))), "\n\r ")
    if length(trim(line, "\n\r ")) > 0 && !startswith(trim(line, "\n\r "), "#")
  }
}

provider "aws" {
  access_key = local.env_map["AWS_ACCESS_KEY_ID"]
  secret_key = local.env_map["AWS_SECRET_ACCESS_KEY"]
  region     = local.env_map["AWS_DEFAULT_REGION"]
}
