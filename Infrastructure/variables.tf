variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "eventverse-rg"
}

variable "location" {
  description = "The Azure region to deploy resources"
  type        = string
  default     = "eastus"
}

variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
  default     = "eventverse-storageacct"
}

variable "container_name" {
  description = "The name of the storage container"
  type        = string
  default     = "media"
}

variable "tags" {
  description = "Tags to be applied to resources"
  type        = map(string)
  default = {
    environment = "production"
    project     = "eventverse"
  }
}
variable "sql_admin_username" {
  description = "The admin username for the SQL database"
  type        = string
}

variable "sql_admin_password" {
  description = "The admin password for the SQL database"
  type        = string
  sensitive   = true
}