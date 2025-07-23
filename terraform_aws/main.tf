module "eks" {
  source       = "./eks"
  cluster_name = var.eks_cluster_name
  vpc_id       = var.vpc_id
}
