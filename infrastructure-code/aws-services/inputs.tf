variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
  default     = "simple-vpc"
}

variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.1.0.0/16"
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.1.1.0/24"
}

variable "availability_zone" {
  description = "AZ for the public subnet"
  type        = string
  default     = "ap-southeast-1a"
}

variable "tags" {
  description = "Tags to apply"
  type        = map(string)
  default = {
    Environment = "dev"
    Project     = "demo-github-action"
  }
}

variable "ami_id" {
  description = "AMI ID for EC2 instance"
  type        = string
  default     = "ami-02c7683e4ca3ebf58"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3a.medium"
}

variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
  default     = "keypair_for_minikube"
}

# ECR's related parameters
variable "ecr_repo_name" {
  description = "Name of the ECR repository"
  type        = string
  default     = "demo-github-action"
}

variable "image_mutability" {
  description = "Whether image tags are mutable or immutable"
  type        = string
  default     = "IMMUTABLE"
}

variable "scan_on_push" {
  description = "Enable image scanning on push"
  type        = bool
  default     = true
}

variable "encryption_type" {
  description = "Type of encryption to use"
  type        = string
  default     = "AES256"
}
