data "aws_lb" "nginx_ingress" {
  tags = {
    "kubernetes.io/service-name" = "ingress-nginx/nginx-ingress-controller"
  }
  depends_on = [helm_release.nginx_ingress]
}
