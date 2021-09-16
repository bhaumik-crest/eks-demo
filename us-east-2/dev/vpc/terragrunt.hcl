include {
    path = find_in_parent_folders()
}

locals {
  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  # Extract out common variables for reuse
  env = local.environment_vars.locals.environment
  aws_region   = local.region_vars.locals.aws_region
}

terraform { 
    source = "/Users/bhaumikj/Desktop/K8s_Learning/EKS-Demo/eks-modules//vpc"
}

inputs = { 
    region = local.aws_region
    cluster_name = "mycluster-${local.env}"
}
