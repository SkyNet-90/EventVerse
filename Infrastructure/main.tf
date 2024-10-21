resource "azurerm_resource_group" "eventverse_rg" {
  name     = "eventverse-rg"
  location = "eastus" # Update this with your preferred Azure region
}

# Setup Azure Key Vault
resource "azurerm_key_vault" "eventverse_kv" {
  name                = "eventverse-keyvault"
  location            = azurerm_resource_group.eventverse_rg.location
  resource_group_name = azurerm_resource_group.eventverse_rg.name
  sku_name            = "standard"
  tenant_id           = data.azurerm_client_config.current.tenant_id

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = ["get", "list", "set"]
  }
}

resource "azurerm_key_vault_secret" "eventverse_sql_admin_username" {
  name         = "sql-admin-username"
  value        = var.sql_admin_username
  key_vault_id = azurerm_key_vault.eventverse_kv.id
}

resource "azurerm_key_vault_secret" "eventverse_sql_admin_password" {
  name         = "sql-admin-password"
  value        = var.sql_admin_password
  key_vault_id = azurerm_key_vault.eventverse_kv.id
}

# Azure Kubernetes Service (AKS)
resource "azurerm_kubernetes_cluster" "eventverse_aks" {
  name                = "eventverse-aks"
  location            = azurerm_resource_group.eventverse_rg.location
  resource_group_name = azurerm_resource_group.eventverse_rg.name
  dns_prefix          = "eventverse"

  default_node_pool {
    name       = "default"
    node_count = 1              # Keep node count to 1 for cost-effectiveness, can scale later
    vm_size    = "Standard_B2s" # Cost-effective option for testing
  }

  identity {
    type = "SystemAssigned"
  }
}
# Azure SQL Database
resource "azurerm_mssql_server" "eventverse_sql_server" {
  name                         = "eventverse-sql-server"
  resource_group_name          = azurerm_resource_group.eventverse_rg.name
  location                     = azurerm_resource_group.eventverse_rg.location
  version                      = "12.0"
  administrator_login          = azurerm_key_vault_secret.eventverse_sql_admin_username.value
  administrator_login_password = azurerm_key_vault_secret.eventverse_sql_admin_password.value
}

resource "azurerm_mssql_database" "eventverse_db" {
  name                = "eventverse-db"
  server_id           = azurerm_mssql_server.eventverse_sql_server.id
  sku_name            = "Basic"
}

# Azure Blob Storage
resource "azurerm_storage_account" "eventverse_storage" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.eventverse_rg.name
  location                 = azurerm_resource_group.eventverse_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS" # Locally redundant storage for cost-effectiveness

  tags = {
    environment = "production"
    project     = "eventverse"
  }

  network_rules {
    default_action = "Deny"
    bypass         = ["AzureServices"]
  }
}

resource "azurerm_storage_container" "eventverse_media" {
  name                  = var.container_name
  storage_account_name  = azurerm_storage_account.eventverse_storage.name
  container_access_type = "private"
}