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
    private_subnets = ["dummy-private-subnets"]
  }
}
dependency "sg" {
  config_path = "../sg"

  mock_outputs = {
    worker_one_id = "dummy-id-1"
    worker_two_id = "dummy-id-2"
  }
}
inputs = {
  vpc_id = dependency.vpc.outputs.vpc_id
  private_subnets = dependency.vpc.outputs.private_subnets
  cluster_name = "mycluster-${local.env}"
  worker_one_id = dependency.sg.outputs.worker_one_id
  worker_two_id = dependency.sg.outputs.worker_two_id
}

terraform { 
    source = "/Users/bhaumikj/Desktop/K8s_Learning/EKS-Demo/eks-modules//eks"
}