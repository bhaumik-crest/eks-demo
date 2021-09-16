include {
    path = find_in_parent_folders()
}

locals {
  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  # Extract out common variables for reuse
  env = local.environment_vars.locals.environment
}

dependency "vpc" {
  config_path = "../vpc"

  mock_outputs = {
    vpc_id = "temporary-dummy-id"
  }
}

inputs = {
  vpc_id = dependency.vpc.outputs.vpc_id
}

terraform { 
    source = "/Users/bhaumikj/Desktop/K8s_Learning/EKS-Demo/eks-modules//sg"
}