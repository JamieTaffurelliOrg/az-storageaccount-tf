# az-storageaccount-tf
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.6.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.104 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 3.104 |
| <a name="provider_azurerm.logs"></a> [azurerm.logs](#provider\_azurerm.logs) | ~> 3.104 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_monitor_diagnostic_setting.storage_account_blob_diagnostics](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_monitor_diagnostic_setting.storage_account_diagnostics](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_private_endpoint.private_endpoint](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_storage_account.storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_account_network_rules.rules](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account_network_rules) | resource |
| [azurerm_storage_container.container](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_log_analytics_workspace.logs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/log_analytics_workspace) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_tier"></a> [access\_tier](#input\_access\_tier) | Tier of blob access | `string` | `"Hot"` | no |
| <a name="input_account_kind"></a> [account\_kind](#input\_account\_kind) | Kind of storage account | `string` | `"StorageV2"` | no |
| <a name="input_account_replication_type"></a> [account\_replication\_type](#input\_account\_replication\_type) | Replication of storage | `string` | n/a | yes |
| <a name="input_account_tier"></a> [account\_tier](#input\_account\_tier) | Tier of storage account | `string` | `"Standard"` | no |
| <a name="input_change_feed_enabled"></a> [change\_feed\_enabled](#input\_change\_feed\_enabled) | Enable blob change feed | `bool` | `true` | no |
| <a name="input_change_feed_retention_in_days"></a> [change\_feed\_retention\_in\_days](#input\_change\_feed\_retention\_in\_days) | Retention of change feed | `number` | `365` | no |
| <a name="input_container_delete_retention_policy_days"></a> [container\_delete\_retention\_policy\_days](#input\_container\_delete\_retention\_policy\_days) | Container soft delete retention | `number` | `365` | no |
| <a name="input_containers"></a> [containers](#input\_containers) | The storage account containers to deploy | `list(string)` | n/a | yes |
| <a name="input_cross_tenant_replication_enabled"></a> [cross\_tenant\_replication\_enabled](#input\_cross\_tenant\_replication\_enabled) | Enable cross tenant replication | `bool` | `false` | no |
| <a name="input_delete_retention_policy_days"></a> [delete\_retention\_policy\_days](#input\_delete\_retention\_policy\_days) | Soft delete retention | `number` | `365` | no |
| <a name="input_last_access_time_enabled"></a> [last\_access\_time\_enabled](#input\_last\_access\_time\_enabled) | Enable last access time | `bool` | `true` | no |
| <a name="input_location"></a> [location](#input\_location) | The location of the storage account to deploy | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_name"></a> [log\_analytics\_workspace\_name](#input\_log\_analytics\_workspace\_name) | Name of Log Analytics Workspace to send diagnostics | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_resource_group_name"></a> [log\_analytics\_workspace\_resource\_group\_name](#input\_log\_analytics\_workspace\_resource\_group\_name) | Resource Group of Log Analytics Workspace to send diagnostics | `string` | n/a | yes |
| <a name="input_private_endpoints"></a> [private\_endpoints](#input\_private\_endpoints) | Cosmos DB private endpoints | <pre>list(object({<br>    name                            = string<br>    location                        = string<br>    subnet_id                       = string<br>    subresource_names               = list(string)<br>    private_service_connection_name = string<br>    private_dns_zone_ids            = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Enable public network access | `bool` | `false` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The resource group of the storage account to deploy | `string` | n/a | yes |
| <a name="input_shared_access_key_enabled"></a> [shared\_access\_key\_enabled](#input\_shared\_access\_key\_enabled) | Enable access keys | `bool` | `false` | no |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | The name of the storage account to deploy | `string` | n/a | yes |
| <a name="input_storage_account_network_rules"></a> [storage\_account\_network\_rules](#input\_storage\_account\_network\_rules) | The Storage Account firewall rules | <pre>object(<br>    {<br>      default_action             = optional(string, "Deny")<br>      ip_rules                   = optional(list(string), [])<br>      virtual_network_subnet_ids = optional(list(string), [])<br>    }<br>  )</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply | `map(string)` | n/a | yes |
| <a name="input_versioning_enabled"></a> [versioning\_enabled](#input\_versioning\_enabled) | Enable blob versioning | `bool` | `true` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->