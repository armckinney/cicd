terraform {
  required_version = "1.9.5"
  backend "local" {}

  required_providers {
    time = {
      source  = "hashicorp/time"
      version = "0.12.0"
    }
  }
}

resource "time_static" "this" {
  rfc3339  = var.file_time
  triggers = {}
}

module "this_file" {
  source = "../../modules/example"

  directory = var.environment
  file_name = "${local.file_name}-${time_static.this.unix}"
  file_type = var.file_type
}
