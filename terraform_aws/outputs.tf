output "eks_cluster_endpoint" {
  value = aws_eks_cluster.eks_cluster.endpoint
}

output "eks_kubeconfig" {
  value = aws_eks_cluster.eks_cluster.kubeconfig
}

output "rds_endpoint" {
  value = aws_db_instance.postgres.address
}

output "app_url" {
  value = kubernetes_service.app.status[0].load_balancer[0].ingress[0].hostname
}