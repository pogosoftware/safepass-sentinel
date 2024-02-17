provider "hcp" {
  project_id = var.hcp_project_id
}

provider "aws" {
  region = var.aws_region
}
