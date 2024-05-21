variable "storage_account_name" {
  type        = string
  description = "The name of the storage account to deploy"
}

variable "location" {
  type        = string
  description = "The location of the storage account to deploy"
}

variable "resource_group_name" {
  type        = string
  description = "The resource group of the storage account to deploy"
}

variable "account_replication_type" {
  type        = string
  description = "Replication of storage"
}

variable "cross_tenant_replication_enabled" {
  type        = bool
  default     = false
  description = "Enable cross tenant replication"
}

variable "account_kind" {
  type        = string
  default     = "StorageV2"
  description = "Kind of storage account"
}

variable "account_tier" {
  type        = string
  default     = "Standard"
  description = "Tier of storage account"
}

variable "access_tier" {
  type        = string
  default     = "Hot"
  description = "Tier of blob access"
}

variable "public_network_access_enabled" {
  type        = bool
  default     = false
  description = "Enable public network access"
}

variable "shared_access_key_enabled" {
  type        = bool
  default     = false
  description = "Enable access keys"
}

variable "versioning_enabled" {
  type        = bool
  default     = true
  description = "Enable blob versioning"
}

variable "change_feed_enabled" {
  type        = bool
  default     = true
  description = "Enable blob change feed"
}

variable "change_feed_retention_in_days" {
  type        = number
  default     = 365
  description = "Retention of change feed"
}

variable "last_access_time_enabled" {
  type        = bool
  default     = true
  description = "Enable last access time"
}

variable "delete_retention_policy_days" {
  type        = number
  default     = 365
  description = "Soft delete retention"
}

variable "container_delete_retention_policy_days" {
  type        = number
  default     = 365
  description = "Container soft delete retention"
}

variable "containers" {
  type        = list(string)
  description = "The storage account containers to deploy"
}

variable "storage_account_network_rules" {
  type = object(
    {
      default_action             = optional(string, "Deny")
      ip_rules                   = optional(list(string), [])
      virtual_network_subnet_ids = optional(list(string), [])
    }
  )
  default     = {}
  description = "The Storage Account firewall rules"
}

variable "private_endpoints" {
  type = list(object({
    name                            = string
    location                        = string
    subnet_id                       = string
    subresource_names               = list(string)
    private_service_connection_name = string
    private_dns_zone_ids            = list(string)
  }))
  default     = []
  description = "Cosmos DB private endpoints"
}

variable "log_analytics_workspace_name" {
  type        = string
  description = "Name of Log Analytics Workspace to send diagnostics"
}

variable "log_analytics_workspace_resource_group_name" {
  type        = string
  description = "Resource Group of Log Analytics Workspace to send diagnostics"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply"
}
