variable "region" {
  description = "AWS Region"
  default     = "us-west-2"
}

variable "vpc_id" {
  description = "VPC ID where EKS will run"
  default     = ""
}

variable "eks_cluster_name" {
  description = "my-web-app-cluster"
  default     = "my-eks-cluster"
}
