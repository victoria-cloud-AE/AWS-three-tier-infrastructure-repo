output "nginx_ingress_lb_dns" {
  value = data.aws_lb.nginx_ingress.dns_name
}

output "nginx_lb_ip" {
  value = data.aws_lb.nginx_ingress.ip_address_type == "ipv4" ? data.aws_lb.nginx_ingress.dns_name : ""
}
output "nginx_ingress_load_balancer_hostname" {
  value = data.aws_lb.nginx_ingress.dns_name
}
# Outputs for the EKS cluster
# output "cluster_name" {
#   value       = aws_eks_cluster.eks.name
#   description = "Name of the EKS cluster"
# }

# output "cluster_endpoint" {
#   value       = aws_eks_cluster.eks.endpoint
#   description = "EKS API endpoint"
# }

# output "cluster_certificate_authority" {
#   value       = aws_eks_cluster.eks.certificate_authority[0].data
#   description = "Base64-encoded CA data"
# }

# # Only output the LB if it exists (after Helm install)
# output "nginx_ingress_dns" {
#   value       = try(data.aws_lb.nginx_ingress.dns_name, "")
#   description = "DNS name of the NGINX ingress"
# }

# output "nginx_ingress_ip" {
#   value       = try(data.aws_lb.nginx_ingress.ip_address_type == "ipv4" ? data.aws_lb.nginx_ingress.dns_name : "", "")
#   description = "IP or DNS of NGINX ingress (IPv4 only)"
# }
