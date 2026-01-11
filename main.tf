# Creating a VPC and EKS cluster using Terraform
module "vpc-deployment" {
  source = "./module-vpc"

  environment       = var.environment
  vpc_cidrblock     = var.vpc_cidrblock
  countsub          = var.countsub
  create_subnet     = var.create_subnet
  create_elastic_ip = var.create_elastic_ip

}

#creating an EKS cluster using Terraform
# and deploying it in the VPC created above
module "eks-deployment" {
  source = "./module-eks"

  environment        = var.environment
  vpc_cidrblock      = var.vpc_cidrblock
  countsub           = var.countsub
  create_subnet      = var.create_subnet
  create_elastic_ip  = var.create_elastic_ip
  desired_size       = var.desired_size
  max_size           = var.max_size
  min_size           = var.min_size
  instance_types     = var.instance_types
  capacity_type      = var.capacity_type
  public_subnet_ids  = module.vpc-deployment.public_subnet_ids
  private_subnet_ids = module.vpc-deployment.private_subnet_ids
  cluster_name       = var.cluster_name
  repository_name    = var.repository_name
  domain_name        = var.domain_name
  email              = var.email

}

# module "namecheap-deployment" {
#     source = "./module-dns"
#     environment = var.environment
#     domain_name = var.domain_name
#     nginx_lb_ip = module.eks-deployment.nginx_lb_ip
#     nginx_ingress_load_balancer_hostname = module.eks-deployment.nginx_ingress_load_balancer_hostname
#     nginx_ingress_lb_dns = module.eks-deployment.nginx_ingress_lb_dns

# }

module "rds-mysql-deployment" {
  source                 = "./module-database"
  environment            = var.environment
  db_instance_class      = var.db_instance_class
  db_allocated_storage   = var.db_allocated_storage
  private_subnet_db_ids  = module.vpc-deployment.private_subnet_db_ids
  db_name                = var.db_name
  db_password            = var.db_password
  db_username            = var.db_username
  aws_security_group_ids = module.vpc-deployment.aws_security_group_ids
}

# Outputs for the EKS cluster
output "cluster_name" {
  value       = aws_eks_cluster.eks.name
  description = "Name of the EKS cluster"
}

output "cluster_endpoint" {
  value       = aws_eks_cluster.eks.endpoint
  description = "EKS cluster API endpoint"
}

output "cluster_certificate_authority" {
  value       = aws_eks_cluster.eks.certificate_authority[0].data
  description = "Base64-encoded CA data for the EKS cluster"
}

# Optional: Load balancer info if nginx-ingress is installed via Helm
output "nginx_ingress_dns" {
  value       = data.aws_lb.nginx_ingress.dns_name
  description = "DNS name of the nginx ingress load balancer"
  depends_on  = [helm_release.nginx_ingress]
}

output "nginx_ingress_ip" {
  value       = data.aws_lb.nginx_ingress.ip_address_type == "ipv4" ? data.aws_lb.nginx_ingress.dns_name : ""
  description = "IP or DNS of nginx ingress (IPv4 only)"
  depends_on  = [helm_release.nginx_ingress]
}
