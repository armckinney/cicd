terraform {
  required_version = "1.10.5"
  backend "azurerm" {
    # note: note if oidc is enabled, can also use:
    # use_oidc             = true # Can also be set via `ARM_USE_OIDC` environment variable.
    # use_azuread_auth     = true # Can also be set via `ARM_USE_AZUREAD` environment variable.
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
