resource "azurerm_resource_group" "terraform_Web_Sql_database" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

resource "azurerm_app_service_plan" "Web_Sql_appserviceplan" {
  name                = var.app_service_plan_name
  location            = azurerm_resource_group.terraform_Web_Sql_database.location
  resource_group_name = azurerm_resource_group.terraform_Web_Sql_database.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "Web_Sql_app_service" {
  name                = var.app_service_name
  location            = azurerm_resource_group.terraform_Web_Sql_database.location
  resource_group_name = azurerm_resource_group.terraform_Web_Sql_database.name
  app_service_plan_id = azurerm_app_service_plan.Web_Sql_appserviceplan.id

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }

  app_settings = {
    "SOME_KEY" = "some_value"
  }

  connection_string {
    name  = "Database"
    type  = "SQLAzure"
    value = "Server=tcp:azurerm_mssql_server.Web_Sql_sqlserver.fully_qualified_domain_name Database=azurerm_mssql_database.Web_Sql_db.name;User ID=azurerm_mssql_server.Web_Sql_sqlserver.administrator_login;Password=azurerm_mssql_server.Web_Sql_sqlserver.administrator_login_password;Trusted_Connection=False;Encrypt=True;"
  }
}

resource "azurerm_mssql_server" "Web_Sql_sqlserver" {
  name                         = var.sql_server_name
  resource_group_name          = azurerm_resource_group.terraform_Web_Sql_database.name
  location                     = azurerm_resource_group.terraform_Web_Sql_database.location
  version                      = var.sql_server_version
  administrator_login          = var.sql_server_admin_login_id
  administrator_login_password = var.sql_server_admin_password
}

resource "azurerm_mssql_database" "Web_Sql_db" {
  name      = var.sql_database_name
  server_id = azurerm_mssql_server.Web_Sql_sqlserver.id
}

resource "azurerm_storage_account" "web_sql_sa" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.terraform_Web_Sql_database.name
  location                 = azurerm_resource_group.terraform_Web_Sql_database.location
  account_tier             = var.storage_account_tier
  account_replication_type = var.storage_account_replication
}

resource "azurerm_mssql_database_extended_auditing_policy" "Web_Sql_policy" {
  database_id                             = azurerm_mssql_database.Web_Sql_db.id
  storage_endpoint                        = azurerm_storage_account.web_sql_sa.primary_blob_endpoint
  storage_account_access_key              = azurerm_storage_account.web_sql_sa.primary_access_key
  storage_account_access_key_is_secondary = false
  retention_in_days                       = 6
}