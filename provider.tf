terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.54.0"
    }
  } 
}

provider "azurerm" {
  # Configuration options
  subscription_id = "6504fe19-55ab-4fb5-884f-9f30f59509f3"
  tenant_id = "d318137f-14e4-4bd6-9256-aa923dacdf8d"
  client_id = "433ec672-96fd-45ee-8053-815758a26d82"
  client_secret = "bIQ8Q~tfzvi3i2foNv5BrX04DPaNdqnt85JcqaW7"
  features {}
}