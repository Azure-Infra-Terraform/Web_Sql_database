variable "resource_group_name" {
  type = string
  description = "Name of the resource groupp to which infra to be deployed"
}

variable "resource_group_location" {
  type = string
  description = "Location of the resource groupp to which infra to be deployed"
}

variable "app_service_plan_name" {
  type = string
  description = "Name of the app service plan"
}

variable "app_service_name" {
  type = string
  description = "Name of the app service"
}

variable "sql_server_name" {
  type = string
  description = "Name of the SQL server"
}

variable "sql_server_admin_login_id" {
  type = string
  description = "Admin Login Id of the SQL server"
}

variable "sql_server_admin_password" {
  type = string
  description = "Admin password of the SQL server"
}

variable "sql_server_version" {
  type = string
  description = "Version of the SQ database"
}
variable "sql_database_name" {
  type = string
  description = "Name of the Database in SQL server"
}

variable "storage_account_name" {
  type = string
  description = "Name of the storage account"
}

variable "storage_account_tier" {
  type = string
  description = "Tier of the storage account"
}

variable "storage_account_replication" {
  type = string
  description = "Replicatin details of storage account"
}