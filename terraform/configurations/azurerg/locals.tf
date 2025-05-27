locals {
  subscription_id = "3af09922-f6bf-46e6-86ea-0d41f2499c90"
  application     = "azurerg"
  location        = "eastus"

  resource_group_name = join("-", ["rg", local.application, var.environment])
  tags = {
    application = local.application
    environment = var.environment
  }

}
