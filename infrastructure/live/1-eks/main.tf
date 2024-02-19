## As there is no time to create a custom managed node group with proper iams we will use a module for sake of simplicity


module "eks" {
  source  = "git::https://github.com/terraform-aws-modules/terraform-aws-eks?ref=v19.0.0"
  cluster_endpoint_private_access = true
## This is nasty shouldn't be accesible but implementing a solution inside the vpc will be very cost time effort
  cluster_endpoint_public_access = true
  cluster_name = var.app

## We don't want to waste too much money at this time, and observability is not part of our delivered product
  create_cloudwatch_log_group = false
## For sake of simplicity we will use this time the eks managed node groups that are created by defualt on the module
  # EKS Managed Node Group
  eks_managed_node_groups = {
    nodes = {
      min_size     = 2
      max_size     = 3
      desired_size = 2
  # No matter if its a on demand instance, its free tier
      instance_types = ["t3.micro"]
      capacity_type  = "SPOT"
    }
  }
## For sake of simplicity we will use the default vpc and subnets fetched from the data
  vpc_id = data.aws_vpc.default.id
  subnet_ids = [data.aws_subnets.default.ids[3],data.aws_subnets.default.ids[4]]
  tags ={}
}