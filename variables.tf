variable "environment" {
  description = "(Required) The name of the environment."
  type        = string
  validation {
    condition = contains([
      "dev",
      "tst",
      "prd",
    ], var.environment)
    error_message = "Possible values are dev, tst, and prd."
  }
}

variable "configuration" {
  description = "(Optional) The configuration for block type arguments."
  type        = any
  default     = null
}

# This `name` variable is replaced by the use of `system_name` and `environment` variables.
# variable "name" {
#   description = "(Required) The name which should be used for this resource. Changing this forces a new resource to be created."
#   type        = string
# }

variable "system_name" {
  description = "(Required) The systen name which should be used for this resource. Changing this forces a new resource to be created."
  type        = string
}

variable "override_name" {
  description = "(Optional) Override the name of the resource. Under normal circumstances, it should not be used."
  default     = null
  type        = string
}

variable "override_location" {
  description = "(Optional) Override the location of the resource. Under normal circumstances, it should not be used."
  default     = null
  type        = string
}

variable "resource_group" {
  description = "(Required) The resource group in which to create the resource."
  type        = any
}

# This `resource_group_name` variable is replaced by the use of `resource_group` variable.
# variable "resource_group_name" {
#   description = "(Required) The name of the resource group where the resource should exist. Changing this forces a new resource to be created."
#   type        = string
# }

# This `location` variable is replaced by the use of `resource_group` variable.
# variable "location" {
#   description = "(Required) The location where the resource should exist. Changing this forces a new resource to be created."
#   type        = string
# }

variable "service_plan_id" {
  description = "(Required) The ID of the Service Plan that this Linux App Service will be created in."
  type        = string
}

# variable "site_config" {
#   description = "(Optional) A `site_config` block as defined in [linux_web_app](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_web_app)."
#   type = object(
#     {
#       always_on             = optional(bool)   # (Optional) If this Linux Web App is Always On enabled. Defaults to `true`. Note: `always_on` must be explicitly set to `false` when using `Free`, `F1`, `D1`, or `Shared` Service Plans.
#       api_definition_url    = optional(string) # (Optional) The URL to the API Definition for this Linux Web App.
#       api_management_api_id = optional(string) # (Optional) The API Management API ID this Linux Web App is associated with.
#       app_command_line      = optional(string) # (Optional) The App command line to launch.

#       application_stack = optional(object({
#         docker_image        = optional(string) # (Optional) The Docker image reference, including repository host as needed.
#         docker_image_tag    = optional(string) # (Optional) The image Tag to use. e.g. `latest`.
#         dotnet_version      = optional(string) # (Optional) The version of .NET to use. Possible values include `3.1`, `5.0`, and `6.0`.
#         java_server         = optional(string) # (Optional) The Java server type. Possible values include `JAVA`, `TOMCAT`, and `JBOSSEAP`. Note: `JBOSSEAP` requires a Premium Service Plan SKU to be a valid option.
#         java_server_version = optional(string) # (Optional) The Version of the `java_server` to use.
#         java_version        = optional(string) # (Optional) The Version of Java to use. Supported versions of Java vary depending on the `java_server` and `java_server_version`, as well as security and fixes to major versions. Please see Azure documentation for the latest information. Note: The valid version combinations for `java_version`, `java_server` and `java_server_version` can be checked from the command line via `az webapp list-runtimes --linux`.
#         node_version        = optional(string) # (Optional) The version of Node to run. Possible values include `12-lts`, `14-lts`, and `16-lts`. This property conflicts with `java_version`. Note: 10.x versions have been/are being deprecated so may cease to work for new resources in the future and may be removed from the provider.
#         php_version         = optional(string) # (Optional) The version of PHP to run. Possible values include `7.4`, and `8.0`. Note: versions `5.6` and `7.2` are deprecated and will be removed from the provider in a future version.
#         python_version      = optional(string) # (Optional) The version of Python to run. Possible values include `3.7`, `3.8`, `3.9` and `3.10`.
#         ruby_version        = optional(string) # (Optional) Te version of Ruby to run. Possible values include `2.6` and `2.7`.
#       }))                                      # (Optional) A `application_stack` block as defined above.

#       auto_heal_enabled = optional(bool) # (Optional) Should Auto heal rules be enabled? Required with `auto_heal_setting`.

#       auto_heal_setting = optional(object({
#         action = optional(object({
#           action_type                    = string           # (Required) Predefined action to be taken to an Auto Heal trigger. Possible values include: `Recycle`.
#           minimum_process_execution_time = optional(string) # (Optional) The minimum amount of time in `hh:mm:ss` the Linux Web App must have been running before the defined action will be run in the event of a trigger.
#         }))                                                 # (Optional) A `action` block as defined above.
#         trigger = optional(object(
#           {
#             requests = optional(object(
#               {
#                 count    = number # (Required) The number of requests in the specified `interval` to trigger this rule.
#                 interval = string # (Required) The interval in `hh:mm:ss`.
#               }
#             )) # (Optional) A requests block as defined above.
#             slow_request = optional(list(
#               object(
#                 {
#                   count      = number           # (Required) The number of Slow Requests in the time `interval` to trigger this rule.
#                   interval   = string           # (Required) The time interval in the form `hh:mm:ss`.
#                   time_taken = string           # (Required) The threshold of time passed to qualify as a Slow Request in `hh:mm:ss`.
#                   path       = optional(string) # (Optional) The path for which this slow request rule applies.
#                 }
#               )
#             )) # (Optional) One or more slow_request blocks as defined above.
#             status_code = optional(list(
#               object(
#                 {
#                   count             = number           # (Required) The number of occurrences of the defined `status_code` in the specified `interval` on which to trigger this rule.
#                   interval          = string           # (Required) The time interval in the form `hh:mm:ss`.
#                   status_code_range = string           # (Required) The status code for this rule, accepts single status codes and status code ranges. e.g. `500` or `400-499`. Possible values are integers between `101` and `599`.
#                   path              = optional(string) # (Optional) The path to which this rule status code applies.
#                   sub_status        = optional(string) # (Optional) The Request Sub Status of the Status Code.
#                   win32_status      = optional(string) # (Optional) The Win32 Status Code of the Request.
#                 }
#               )
#             )) # (Optional) One or more status_code blocks as defined above.
#           }
#         )) # (Optional) A `trigger` block as defined above.
#       }))  # (Optional) A `auto_heal_setting` block as defined above. Required with `auto_heal`.

#       container_registry_managed_identity_client_id = optional(string) # (Optional) The Client ID of the Managed Service Identity to use for connections to the Azure Container Registry.
#       container_registry_use_managed_identity       = optional(string) # (Optional) Should connections for Azure Container Registry use Managed Identity.

#       cors = optional(object({
#         allowed_origins     = list(string)   # (Required) Specifies a list of origins that should be allowed to make cross-origin calls.
#         support_credentials = optional(bool) # (Optional) Whether CORS requests with credentials are allowed. Defaults to `false`.
#       }))                                    # (Optional) A `cors` block as defined above.

#       default_documents                 = optional(list(string)) # (Optional) Specifies a list of Default Documents for the Linux Web App.
#       ftps_state                        = optional(string)       # (Optional) The State of FTP / FTPS service. Possible values include `AllAllowed`, `FtpsOnly`, and `Disabled`. Note: Azure defaults this value to `AllAllowed`, however, in the interests of security Terraform will default this to `Disabled` to ensure the user makes a conscious choice to enable it.
#       health_check_path                 = optional(string)       # (Optional) The path to the Health Check.
#       health_check_eviction_time_in_min = optional(number)       # (Optional) The amount of time in minutes that a node can be unhealthy before being removed from the load balancer. Possible values are between `2` and `10`. Only valid in conjunction with `health_check_path`.
#       http2_enabled                     = optional(bool)         # (Optional) Should the HTTP2 be enabled?

#       ip_restriction = optional(object({
#         action = optional(string) # (Optional) The action to take. Possible values are `Allow` or `Deny`.
#         headers = optional(object(
#           {
#             x_azure_fdid      = optional(list(string)) # (Optional) Specifies a list of Azure Front Door IDs.
#             x_fd_health_probe = optional(bool)         # (Optional) Specifies if a Front Door Health Probe should be expected.
#             x_forwarded_for   = optional(list(string)) # (Optional) Specifies a list of addresses for which matching should be applied. Omitting this value means allow any.
#             x_forwarded_host  = optional(list(string)) # (Optional) Specifies a list of Hosts for which matching should be applied.
#             # Note: Please see the [official Azure Documentation](https://docs.microsoft.com/azure/app-service/app-service-ip-restrictions#filter-by-http-header) for details on using header filtering.
#           }
#         ))                                           # (Optional) A `headers` block as defined above.
#         ip_address                = optional(string) # (Optional) The CIDR notation of the IP or IP Range to match. For example: `10.0.0.0/24` or `192.168.10.1/32`.
#         name                      = optional(string) # (Optional) The name which should be used for this `ip_restriction`.
#         priority                  = optional(string) # (Optional) The priority value of this `ip_restriction`.
#         service_tag               = optional(string) # (Optional) The Service Tag used for this IP Restriction.
#         virtual_network_subnet_id = optional(string) # (Optional) The Virtual Network Subnet ID used for this IP Restriction.
#         # Note: One and only one of `ip_address`, `service_tag` or `virtual_network_subnet_id` must be specified.
#       })) # (Optional) One or more `ip_restriction` blocks as defined above.

#       load_balancing_mode      = optional(string) # (Optional) The Site load balancing. Possible values include: `WeightedRoundRobin`, `LeastRequests`, `LeastResponseTime`, `WeightedTotalTraffic`, `RequestHash`, `PerSiteRoundRobin`. Defaults to `LeastRequests` if omitted.
#       local_mysql_enabled      = optional(bool)   # (Optional) Use Local MySQL. Defaults to `false`.
#       managed_pipeline_mode    = optional(string) # (Optional) Managed pipeline mode. Possible values include `Integrated`, and `Classic`.
#       minimum_tls_version      = optional(string) # (Optional) The configures the minimum version of TLS required for SSL requests. Possible values include: `1.0`, `1.1`, and  `1.2`. Defaults to `1.2`.
#       remote_debugging_enabled = optional(bool)   # (Optional) Should Remote Debugging be enabled? Defaults to `false`.
#       remote_debugging_version = optional(string) # (Optional) The Remote Debugging Version. Possible values include `VS2017` and `VS2019`

#       scm_ip_restriction = optional(object({
#         action = optional(string) # (Optional) The action to take. Possible values are `Allow` or `Deny`.
#         headers = optional(object(
#           {
#             x_azure_fdid      = optional(list(string)) # (Optional) Specifies a list of Azure Front Door IDs.
#             x_fd_health_probe = optional(bool)         # (Optional) Specifies if a Front Door Health Probe should be expected.
#             x_forwarded_for   = optional(list(string)) # (Optional) Specifies a list of addresses for which matching should be applied. Omitting this value means allow any.
#             x_forwarded_host  = optional(list(string)) # (Optional) Specifies a list of Hosts for which matching should be applied.
#             # Note: Please see the [official Azure Documentation](https://docs.microsoft.com/azure/app-service/app-service-ip-restrictions#filter-by-http-header) for details on using header filtering.
#           }
#         ))                                           # (Optional) A `headers` block as defined above.
#         ip_address                = optional(string) # (Optional) The CIDR notation of the IP or IP Range to match. For example: `10.0.0.0/24` or `192.168.10.1/32`.
#         name                      = optional(string) # (Optional) The name which should be used for this `ip_restriction`.
#         priority                  = optional(string) # (Optional) The priority value of this `ip_restriction`.
#         service_tag               = optional(string) # (Optional) The Service Tag used for this IP Restriction.
#         virtual_network_subnet_id = optional(string) # (Optional) The Virtual Network Subnet ID used for this IP Restriction.
#         # Note: One and only one of `ip_address`, `service_tag` or `virtual_network_subnet_id` must be specified.
#       })) # (Optional) One or more `scm_ip_restriction` blocks as defined above.

#       scm_minimum_tls_version     = optional(string) # (Optional) The configures the minimum version of TLS required for SSL requests to the SCM site Possible values include: `1.0`, `1.1`, and  `1.2`. Defaults to `1.2`.
#       scm_use_main_ip_restriction = optional(bool)   # (Optional) Should the Linux Web App `ip_restriction` configuration be used for the SCM also.
#       use_32_bit_worker           = optional(bool)   # (Optional) Should the Linux Web App use a 32-bit worker? Defaults to `true`.
#       vnet_route_all_enabled      = optional(bool)   # (Optional) Should all outbound traffic have NAT Gateways, Network Security Groups and User Defined Routes applied? Defaults to `false`.
#       websockets_enabled          = optional(bool)   # (Optional) Should Web Sockets be enabled? Defaults to `false`.
#       worker_count                = optional(number) # (Optional) The number of Workers for this Linux App Service.
#     }
#   )
#   default = {}
# }

variable "app_settings" {
  description = "(Optional) A map of key-value pairs of App Settings as defined in [linux_web_app](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_web_app)."
  type        = map(any)
}

# variable "auth_settings" {
#   description = "(Optional) A `auth_settings` block as defined in [linux_web_app](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_web_app)."
#   type = object(
#     {
#       enabled = bool # (Required) Should the Authentication / Authorization feature be enabled for the Linux Web App?

#       active_directory = optional(object(
#         {
#           client_id                  = string                 # (Required) The ID of the Client to use to authenticate with Azure Active Directory.
#           allowed_audiences          = optional(list(string)) # (Optional) Specifies a list of Allowed audience values to consider when validating JWTs issued by Azure Active Directory. Note: The `client_id` value is always considered an allowed audience.
#           client_secret              = optional(string)       # (Optional) The Client Secret for the Client ID. Cannot be used with `client_secret_setting_name`.
#           client_secret_setting_name = optional(string)       # (Optional) The App Setting name that contains the client secret of the Client. Cannot be used with `client_secret`.
#         }
#       )) # (Optional) An `active_directory` block as defined above.

#       additional_login_parameters    = optional(map(string))  # (Optional) Specifies a map of login Parameters to send to the OpenID Connect authorization endpoint when a user logs in.
#       allowed_external_redirect_urls = optional(list(string)) # (Optional) Specifies a list of External URLs that can be redirected to as part of logging in or logging out of the Linux Web App.
#       default_provider               = optional(string)       # (Optional) The default authentication provider to use when multiple providers are configured. Possible values include: `BuiltInAuthenticationProviderAzureActiveDirectory`, `BuiltInAuthenticationProviderFacebook`, `BuiltInAuthenticationProviderGoogle`, `BuiltInAuthenticationProviderMicrosoftAccount`, `BuiltInAuthenticationProviderTwitter`, `BuiltInAuthenticationProviderGithub`. Note: This setting is only needed if multiple providers are configured, and the `unauthenticated_client_action` is set to "RedirectToLoginPage".

#       facebook = optional(object(
#         {
#           app_id                  = string           # (Required) The App ID of the Facebook app used for login.
#           app_secret              = optional(string) # (Optional) The App Secret of the Facebook app used for Facebook login. Cannot be specified with `app_secret_setting_name`.
#           app_secret_setting_name = optional(string) # (Optional) The app setting name that contains the `app_secret` value used for Facebook login. Cannot be specified with `app_secret`.
#           oauth_scopes            = optional(string) # (Optional) Specifies a list of OAuth 2.0 scopes to be requested as part of Facebook login authentication.
#         }
#       )) # (Optional) A `facebook` block as defined above.

#       github = optional(object(
#         {
#           client_id                  = string           # (Required) The ID of the GitHub app used for login.
#           client_secret              = optional(string) # (Optional) The Client Secret of the GitHub app used for GitHub login. Cannot be specified with `client_secret_setting_name`.
#           client_secret_setting_name = optional(string) # (Optional) The app setting name that contains the `client_secret` value used for GitHub login. Cannot be specified with `client_secret`.
#           oauth_scopes               = optional(string) # (Optional) Specifies a list of OAuth 2.0 scopes that will be requested as part of GitHub login authentication.
#         }
#       )) # (Optional) A `github` block as defined above.

#       google = optional(object(
#         {
#           client_id                  = string           # (Required) The OpenID Connect Client ID for the Google web application.
#           client_secret              = optional(string) # (Optional) The client secret associated with the Google web application.  Cannot be specified with `client_secret_setting_name`.
#           client_secret_setting_name = optional(string) # (Optional) The app setting name that contains the `client_secret` value used for Google login. Cannot be specified with `client_secret`.
#           oauth_scopes               = optional(string) # (Optional) Specifies a list of OAuth 2.0 scopes that will be requested as part of Google Sign-In authentication. If not specified, `openid`, `profile`, and `email` are used as default scopes.
#         }
#       )) # (Optional) A `google` block as defined above.

#       issuer = optional(string) # (Optional) The OpenID Connect Issuer URI that represents the entity that issues access tokens for this Linux Web App. Note: When using Azure Active Directory, this value is the URI of the directory tenant, e.g. https://sts.windows.net/{tenant-guid}/.

#       microsoft = optional(object(
#         {
#           client_id                  = string           # (Required) The OAuth 2.0 client ID that was created for the app used for authentication.
#           client_secret              = optional(string) # (Optional) The OAuth 2.0 client secret that was created for the app used for authentication. Cannot be specified with `client_secret_setting_name`.
#           client_secret_setting_name = optional(string) # (Optional) The app setting name containing the OAuth 2.0 client secret that was created for the app used for authentication. Cannot be specified with `client_secret`.
#           oauth_scopes               = optional(string) # (Optional) Specifies a list of OAuth 2.0 scopes that will be requested as part of Microsoft Account authentication. If not specified, "wl.basic" is used as the default scope.
#         }
#       )) # (Optional) A `microsoft` block as defined above.

#       runtime_version               = optional(string) # (Optional) The RuntimeVersion of the Authentication / Authorization feature in use for the Linux Web App.
#       token_refresh_extension_hours = optional(number) # (Optional) The number of hours after session token expiration that a session token can be used to call the token refresh API. Defaults to `72` hours.
#       token_store_enabled           = optional(bool)   # (Optional) Should the Linux Web App durably store platform-specific security tokens that are obtained during login flows? Defaults to `false`.

#       twitter = optional(object(
#         {
#           consumer_key                 = string           # (Required) The OAuth 1.0a consumer key of the Twitter application used for sign-in.
#           consumer_secret              = optional(string) # (Optional) The OAuth 1.0a consumer secret of the Twitter application used for sign-in. Cannot be specified with `consumer_secret_setting_name`.
#           consumer_secret_setting_name = optional(string) # (Optional) The app setting name that contains the OAuth 1.0a consumer secret of the Twitter application used for sign-in. Cannot be specified with `consumer_secret`.
#         }
#       )) # (Optional) A `twitter` block as defined above.

#       unauthenticated_client_action = optional(string) # (Optional) The action to take when an unauthenticated client attempts to access the app. Possible values include: `RedirectToLoginPage`, `AllowAnonymous`.
#     }
#   )
#   default = {
#     enabled = false
#     #   active_directory               = null
#     #   additional_login_parameters    = {}
#     #   allowed_external_redirect_urls = []
#     #   default_provider               = null
#     #   facebook                       = null
#     #   github                         = null
#     #   google                         = null
#     #   issuer                         = null
#     #   microsoft                      = null
#     #   runtime_version                = null
#     #   token_refresh_extension_hours  = null
#     #   token_store_enabled            = null
#     #   twitter                        = null
#     #   unauthenticated_client_action  = null
#   }
# }

# variable "backup" {
#   description = "(Optional) A `backup` block as documented [here](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_web_app)."
#   type = object(
#     {
#       name = string # (Required) The name which should be used for this Backup.

#       schedule = optional(object(
#         {
#           frequency_interval       = string           # (Required) How often the backup should be executed (e.g. for weekly backup, this should be set to `7` and `frequency_unit` should be set to `Day`). Note: Not all intervals are supported on all Linux Web App SKUs. Please refer to the official documentation for appropriate values.
#           frequency_unit           = optional(string) # (Required) The unit of time for how often the backup should take place. Possible values include: `Day`, `Hour`
#           keep_at_least_one_backup = optional(bool)   # (Optional) Should the service keep at least one backup, regardless of the age of backup? Defaults to `false`.
#           retention_period_days    = optional(number) # (Optional) After how many days backups should be deleted.
#           start_time               = optional(string) # (Optional) When the schedule should start working in RFC-3339 format.
#         }
#       )) # (Required) A `schedule` block as defined above.

#       storage_account_url = optional(string) # (Required) The SAS URL to the container.
#       enabled             = optional(bool)   # (Optional) Should this backup job be enabled?
#     }
#   ) # (Optional) A `backup` block as defined above.
#   default = null
# }

variable "client_affinity_enabled" {
  description = "(Optional) Should Client Affinity be enabled?"
  type        = bool
}

variable "client_certificate_enabled" {
  description = "(Optional) Should Client Certificates be enabled?"
  type        = bool
}

variable "client_certificate_mode" {
  description = "(Optional) The Client Certificate mode. Possible values are `Required`, `Optional`, and `OptionalInteractiveUser`. This property has no effect when `client_certificate_enabled` is `false`."
  type        = string
  validation {
    condition     = can(regex("^(Required|Optional|OptionalInteractiveUser)$", var.client_certificate_mode))
    error_message = "Possible values are `Required`, `Optional`, and `OptionalInteractiveUser`."
  }
}

# https://github.com/hashicorp/terraform-provider-azurerm/blob/main/CHANGELOG.md#3280-october-20-2022
# variable "client_certificate_exclusion_paths" {
#   description = "(Optional) Paths to exclude when using client certificates, separated by `;`."
#   type        = string
# }

# variable "connection_string" {
#   description = "(Optional) A `connection_string` block as defined in [linux_web_app](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_web_app)."
#   type = object(
#     {
#       name  = string # (Required) The name of the Connection String.
#       type  = string # (Required) Type of database. Possible values include: `MySQL`, `SQLServer`, `SQLAzure`, `Custom`, `NotificationHub`, `ServiceBus`, `EventHub`, `APIHub`, `DocDb`, `RedisCache`, and `PostgreSQL`.
#       value = string # (Required) The connection string value.
#     }
#   )
#   default = null
# } # (Optional) One or more `connection_string` blocks as defined above.

variable "enabled" {
  description = "(Optional) Should the Linux Web App be enabled? Defaults to `true`."
  type        = bool
}

variable "https_only" {
  description = "(Optional) Should the Linux Web App require HTTPS connections."
  type        = bool
}

# variable "identity" {
#   description = "(Optional) An identity block as defined below which contains the Managed Service Identity information for this resource."
#   type = object(
#     {
#       type         = string                 # (Required) Specifies the type of Managed Service Identity that should be configured on this resource. Possible values are `SystemAssigned`, `UserAssigned` and `SystemAssigned, UserAssigned` (to enable both).
#       identity_ids = optional(list(string)) # (Optional) A list of User Assigned Managed Identity IDs to be assigned to this resource.
#     }
#   ) # (Optional) An `identity` block as defined above.
#   default = {
#     type = "SystemAssigned"
#   }
# }

variable "key_vault_reference_identity_id" {
  description = "(Optional) The User Assigned Identity ID used for accessing KeyVault secrets. The identity must be assigned to the application in the `identity` block. [For more information see - Access vaults with a user-assigned identity](https://docs.microsoft.com/azure/app-service/app-service-key-vault-references#access-vaults-with-a-user-assigned-identity)."
  type        = string
}

# variable "logs" {
#   description = "(Optional) A `logs` block as documented [here](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_web_app)."
#   type = object(
#     {
#       application_logs = optional(object(
#         {
#           azure_blob_storage = optional(object(
#             {
#               level             = string # (Required) The level at which to log. Possible values include `Error`, `Warning`, `Information`, `Verbose` and `Off`. **NOTE:** this field is not available for `http_logs`
#               retention_in_days = string # (Required) The time in days after which to remove blobs. A value of `0` means no retention.
#               sas_url           = string # (Required) SAS url to an Azure blob container with read/write/list/delete permissions.
#             }
#           )) # (Optional) An `azure_blob_storage` block as defined above.

#           file_system_level = string # (Required) Log level. Possible values include: `Verbose`, `Information`, `Warning`, and `Error`.
#         }
#       )) # (Optional) A `application_logs` block as defined above.

#       detailed_error_messages = optional(bool) # (Optional) Should detailed error messages be enabled?
#       failed_request_tracing  = optional(bool) # (Optional) Should the failed request tracing be enabled?

#       http_logs = optional(object(
#         {
#           azure_blob_storage = optional(object(
#             {
#               # level             = string # (Required) The level at which to log. Possible values include `Error`, `Warning`, `Information`, `Verbose` and `Off`. **NOTE:** this field is not available for `http_logs`
#               retention_in_days = string # (Required) The time in days after which to remove blobs. A value of `0` means no retention.
#               sas_url           = string # (Required) SAS url to an Azure blob container with read/write/list/delete permissions.
#             }
#           )) # (Optional) An `azure_blob_storage` block as defined above.
#           file_system = optional(object(
#             {
#               retention_in_days = number # (Required) The retention period in days. A value of `0` means no retention.
#               retention_in_mb   = number # (Required) The maximum size in megabytes that log files can use.
#             }
#           )) # (Optional) A `file_system` block as defined above.
#         }
#       )) # (Optional) An `http_logs` block as defined above.
#     }
#   ) # (Optional) A `logs` block as defined above.
#   default = {
#     application_logs        = null
#     detailed_error_messages = false
#     failed_request_tracing  = false
#     http_logs               = null
#   }
# }

# variable "storage_account" {
#   description = "(Optional) A `storage_account` block as documented [here](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_web_app)."
#   type = object(
#     {
#       access_key   = string # (Required) The Access key for the storage account.
#       account_name = string # (Required) The Name of the Storage Account.
#       name         = string # (Required) The name which should be used for this Storage Account.
#       share_name   = string # (Required) The Name of the File Share or Container Name for Blob storage.
#       type         = string # (Required) The Azure Storage Type. Possible values include `AzureFiles` and `AzureBlob`.
#       mount_path   = string # (Optional) The path at which to mount the storage share.
#     }
#   ) # (Optional) One or more `storage_account` blocks as defined above.
#   default = null
# }

# variable "sticky_settings" {
#   description = "(Optional) A `sticky_settings` block as documented [here](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_web_app)."
#   type = object(
#     {
#       app_setting_names       = optional(list(string)) # (Optional) A list of `app_setting` names that the Linux Web App will not swap between Slots when a swap operation is triggered.
#       connection_string_names = optional(list(string)) # (Optional) A list of `connection_string` names that the Linux Web App will not swap between Slots when a swap operation is triggered.
#     }
#   ) # (Optional) A `sticky_settings` block as defined above.
#   default = {}
# }

variable "virtual_network_subnet_id" {
  description = "(Optional) The subnet id which will be used by this Web App for [regional virtual network integration](https://docs.microsoft.com/en-us/azure/app-service/overview-vnet-integration#regional-virtual-network-integration)."
  type        = string
}

variable "zip_deploy_file" {
  description = "(Optional) The local path and filename of the Zip packaged application to deploy to this Linux Web App."
  type        = string
}

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
