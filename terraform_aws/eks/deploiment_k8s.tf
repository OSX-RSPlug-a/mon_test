# EKS Cluster
resource "aws_eks_cluster" "eks_cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_role.arn

  vpc_config {
    subnet_ids = ["<your-subnet-ids>"]
  }
}

# IAM Role for EKS
resource "aws_iam_role" "eks_role" {
  name = "${var.cluster_name}-role"
  assume_role_policy = jsonencode({
    Version = "2025-07-21"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "eks.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })
}

# IAM Role Policy Attachment
resource "aws_iam_role_policy_attachment" "eks-service-policy" {
  role       = aws_iam_role.eks_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
}

# Node Group
resource "aws_eks_node_group" "default" {
  cluster_name    = var.cluster_name
  node_group_name = "${var.cluster_name}-nodes"
  node_role_arn   = aws_iam_role.node_role.arn
  subnet_ids      = ["<your-subnet-ids>"]
  scaling_config {
    desired_size = 2
    max_size     = 4
    min_size     = 1
  }
}

# IAM Role for Nodes
resource "aws_iam_role" "node_role" {
  name = "${var.cluster_name}-node-role"
  assume_role_policy = jsonencode({
    Version = "2025-07-21"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })
}

# Attach necessary policies to node role
resource "aws_iam_role_policy_attachment" "node-AmazonEKSWorkerNodePolicy" {
  role       = aws_iam_role.node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "node-AmazonEC2ContainerRegistryReadOnly" {
  role       = aws_iam_role.node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role_policy_attachment" "node-AmazonEKS_CNI_Policy" {
  role       = aws_iam_role.node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

# Kubernetes Provider
provider "kubernetes" {
  host                   = aws_eks_cluster.eks_cluster.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.eks_cluster.certificate_authority[0].data)
  token_providers {
    oidc {
      issuer_url = aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
    }
  }
}

# Deployment
resource "kubernetes_deployment" "app" {
  metadata {
    name = "myapp"
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "myapp"
      }
    }

    template {
      metadata {
        labels = {
          app = "myapp"
        }
      }

      spec {
        container {
          image = "your-docker-image:latest"
          name  = "app"
          port {
            container_port = 80
          }
        }
      }
    }
  }
}

# Service
resource "kubernetes_service" "app" {
  metadata {
    name = "myapp-service"
  }

  spec {
    selector = {
      app = "myapp"
    }
    port {
      port        = 80
      target_port = 80
    }
    type = "LoadBalancer"
  }
}