## Fetching The auth data of the cluster

data "aws_eks_cluster" "cluster" {
  name = var.app
}

data "aws_eks_cluster_auth" "cluster" {
  name = var.app
}