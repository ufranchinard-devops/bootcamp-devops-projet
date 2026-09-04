output "docker_ec2_id" {
  value = module.ec2_docker[0].ec2_id
}

output "docker_ec2_public_ip" {
  value = module.ec2_docker[0].ec2_public_ip
}