terraform {
    backend "azurerm" {
    resource_group_name   = "terraform_Web_Sql_database"   # Replace with your resource group name
    storage_account_name  = "terraformwebsqldatabase" # Replace with your storage account name
    container_name        = "terraformwebsqldb"      # Replace with the container name
    key                   = "statekey"
  } 
}
