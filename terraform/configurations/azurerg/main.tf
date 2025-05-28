terraform {
  required_version = "1.10.5"
  backend "azurerm" {
    # note: if oidc is enabled, can also use:
    # use_oidc             = true
    # use_azuread_auth     = true
  }

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
