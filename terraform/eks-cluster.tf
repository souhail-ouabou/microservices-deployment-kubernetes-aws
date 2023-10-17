module "eks_blueprints" {
  source = "github.com/aws-ia/terraform-aws-eks-blueprints?ref=v4.25.0"


  cluster_name    = "fleetman"
  cluster_version = "1.25"
  enable_irsa     = true

  vpc_id             = module.myapp-vpc.vpc_id
  private_subnet_ids = module.myapp-vpc.private_subnets

  tags = {
    environment = "development"
    application = "myapp"
  }

  managed_node_groups = {
    role = {
      node_group_name = "general"
      min_size        = 3
      max_size        = 5
      desired_size    = 3
      instance_types  = ["t2.small"]
    }
  }
}

provider "kubernetes" {
  host                   = module.eks_blueprints.eks_cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks_blueprints.eks_cluster_certificate_authority_data)

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    # This requires the awscli to be installed locally where Terraform is executed
    args = ["eks", "get-token", "--cluster-name", module.eks_blueprints.eks_cluster_id]
  }
}
