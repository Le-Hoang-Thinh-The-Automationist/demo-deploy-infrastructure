output "public_ip_ec2" {
  value = module.ec2.public_ip   
}

output "ecr_url" {
  value = module.ecr_repo.repository_url
}