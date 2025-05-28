terraform {
  required_version = "1.10.5"
  backend "azurerm" {}

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.30.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "this" {
  name     = join("-", ["rg", local.application, var.environment])
  location = local.location
  tags     = local.tags
}
