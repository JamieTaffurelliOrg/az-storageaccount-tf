resource "azurerm_storage_account" "storage" {
  #checkov:skip=CKV2_AZURE_33:This is an old way of logging, diagnostics are enabled
  #checkov:skip=CKV_AZURE_33:This is an old way of logging, diagnostics are enabled
  #checkov:skip=CKV2_AZURE_18:This is unnecessary for most scenarios
  #checkov:skip=CKV2_AZURE_1:We may require some storage accounts to not have firewalls
  #checkov:skip=CKV_AZURE_59:Value is deprecated
  name                             = var.storage_account_name
  location                         = var.location
  resource_group_name              = var.resource_group_name
  account_kind                     = var.account_kind
  account_tier                     = var.account_tier
  account_replication_type         = var.account_replication_type
  access_tier                      = var.access_tier
  enable_https_traffic_only        = true
  min_tls_version                  = "TLS1_2"
  allow_nested_items_to_be_public  = false
  shared_access_key_enabled        = var.shared_access_key_enabled
  default_to_oauth_authentication  = true
  public_network_access_enabled    = var.public_network_access_enabled
  cross_tenant_replication_enabled = var.cross_tenant_replication_enabled

  blob_properties {
    versioning_enabled            = var.versioning_enabled
    change_feed_enabled           = var.change_feed_enabled
    change_feed_retention_in_days = var.change_feed_retention_in_days
    last_access_time_enabled      = var.last_access_time_enabled

    delete_retention_policy {
      days = var.delete_retention_policy_days
    }

    container_delete_retention_policy {
      days = var.container_delete_retention_policy_days
    }
  }

  identity {
    type = "SystemAssigned"
  }
  tags = var.tags
}

resource "azurerm_storage_container" "container" {
  #checkov:skip=CKV2_AZURE_21:This is an old way of logging, diagnostics are enabled
  for_each              = toset(var.containers)
  name                  = each.key
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}

resource "azurerm_storage_account_network_rules" "rules" {
  #checkov:skip=CKV_AZURE_35:We may require these storage accounts to be publicly accessible
  storage_account_id         = azurerm_storage_account.storage.id
  default_action             = var.storage_account_network_rules.default_action
  ip_rules                   = var.storage_account_network_rules.ip_rules
  virtual_network_subnet_ids = var.storage_account_network_rules.virtual_network_subnet_ids
  bypass                     = ["Logging", "Metrics", "AzureServices"]
}

resource "azurerm_monitor_diagnostic_setting" "storage_account_diagnostics" {
  name                       = "${var.log_analytics_workspace_name}-security-logging"
  target_resource_id         = azurerm_storage_account.storage.id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.logs.id

  metric {
    category = "Transaction"
  }

  metric {
    category = "Capacity"
    enabled  = false
  }
}

resource "azurerm_monitor_diagnostic_setting" "storage_account_blob_diagnostics" {
  for_each                   = toset(["blobServices", "fileServices", "tableServices", "queueServices"])
  name                       = "${var.log_analytics_workspace_name}-security-logging"
  target_resource_id         = "${azurerm_storage_account.storage.id}/${each.key}/default/"
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.logs.id

  enabled_log {
    category = "StorageRead"
  }

  enabled_log {
    category = "StorageWrite"
  }

  enabled_log {
    category = "StorageDelete"
  }

  metric {
    category = "Transaction"
    enabled  = true
  }

  metric {
    category = "Capacity"
    enabled  = false
  }
}

resource "azurerm_private_endpoint" "private_endpoint" {
  for_each            = { for k in var.private_endpoints : k.name => k if k != null }
  name                = each.key
  resource_group_name = var.resource_group_name
  location            = each.value["location"]
  subnet_id           = each.value["subnet_id"]

  private_service_connection {
    name                           = each.value["private_service_connection_name"]
    private_connection_resource_id = azurerm_storage_account.storage.id
    is_manual_connection           = false
    subresource_names              = each.value["subresource_names"]
  }

  private_dns_zone_group {
    name                 = "customdns"
    private_dns_zone_ids = each.value["private_dns_zone_ids"]
  }
}
