terraform {
  required_version = "1.10.5"
  backend "local" {}

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.30.0"
    }
  }
}

resource "azurerm_resource_group" "this" {
  name     = join("-", ["rg", local.application, var.environment])
  location = local.location
  tags     = local.tags
}
