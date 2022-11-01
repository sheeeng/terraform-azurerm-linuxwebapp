locals {
  name     = var.override_name == null ? "${var.system_name}-${lower(var.environment)}-app" : var.override_name
  location = var.override_location == null ? var.resource_group.location : var.override_location
}

resource "azurerm_linux_web_app" "linux_web_app" {
  name                = local.name
  location            = local.location
  resource_group_name = var.resource_group.name

  service_plan_id = var.service_plan_id

  site_config {
    always_on             = lookup(var.configuration.site_config.value, "always_on", null)
    api_definition_url    = lookup(var.configuration.site_config.value, "api_definition_url", null)
    api_management_api_id = lookup(var.configuration.site_config.value, "api_management_api_id", null)
    app_command_line      = lookup(var.configuration.site_config.value, "app_command_line", null)

    dynamic "application_stack" {
      for_each = lookup(var.configuration.site_config.value, "application_stack", {})
      content {
        docker_image        = lookup(application_stack.value, "docker_image", null)
        docker_image_tag    = lookup(application_stack.value, "docker_image_tag", null)
        dotnet_version      = lookup(application_stack.value, "dotnet_version", null)
        java_server_version = lookup(application_stack.value, "java_server_version", null)
        java_version        = lookup(application_stack.value, "java_version", null)
        node_version        = lookup(application_stack.value, "node_version", null)
        php_version         = lookup(application_stack.value, "php_version", null)
        python_version      = lookup(application_stack.value, "python_version", null)
        ruby_version        = lookup(application_stack.value, "ruby_version", null)
      }
    }

    auto_heal_enabled = lookup(var.configuration.site_config.value, "auto_heal_enabled", null)

    dynamic "auto_heal_setting" {
      for_each = lookup(var.configuration.site_config.value, "auto_heal_setting", {})

      content {
        dynamic "action" {
          for_each = lookup(auto_heal_setting.value, "action", {})
          content {
            action_type                    = action.value.action_type
            minimum_process_execution_time = lookup(action.value, "minimum_process_execution_time")
          }
        }

        dynamic "trigger" {
          for_each = lookup(auto_heal_setting.value, "trigger", {})

          content {
            dynamic "requests" {
              for_each = trigger.value.requests
              content {
                count    = requests.value.count
                interval = requests.value.interval
              }
            }

            dynamic "slow_request" {
              for_each = lookup(auto_heal_setting.value, "slow_request", [])
              content {
                count      = slow_request.value.count
                interval   = slow_request.value.interval
                time_taken = slow_request.value.time_taken
                path       = lookup(slow_request.value, "path", null)
              }
            }

            dynamic "status_code" {
              for_each = lookup(auto_heal_setting.value, "status_code", [])
              content {
                count             = status_code.value.count
                interval          = status_code.value.interval
                status_code_range = status_code.value.status_code_range
                path              = lookup(status_code.value, "path", null)
                sub_status        = lookup(status_code.value, "sub_status", null)
                win32_status      = lookup(status_code.value, "win32_status", null)
              }
            }
          }
        }
      }
    }

    container_registry_managed_identity_client_id = lookup(var.configuration.site_config.value, "container_registry_managed_identity_client_id", null)
    container_registry_use_managed_identity       = lookup(var.configuration.site_config.value, "container_registry_use_managed_identity", null)

    dynamic "cors" {
      for_each = lookup(var.configuration.site_config.value, "cors", {})
      content {
        allowed_origins     = cors.value.allowed_origins
        support_credentials = lookup(cors.value, "support_credentials", null)
      }
    }

    default_documents                 = lookup(var.configuration.site_config.value, "default_documents", null)
    ftps_state                        = lookup(var.configuration.site_config.value, "ftps_state", null)
    health_check_path                 = lookup(var.configuration.site_config.value, "health_check_path", null)
    health_check_eviction_time_in_min = lookup(var.configuration.site_config.value, "health_check_eviction_time_in_min", null)
    http2_enabled                     = lookup(var.configuration.site_config.value, "http2_enabled", null)

    dynamic "ip_restriction" {
      for_each = lookup(var.configuration.site_config.value, "ip_restriction", {})
      content {
        action = ip_restriction.value.action

        dynamic "headers" {
          for_each = lookup(ip_restriction.value, "headers", {})
          content {
            x_azure_fdid      = lookup(headers.value, "x_azure_fdid", [])
            x_fd_health_probe = lookup(headers.value, "x_fd_health_probe", null)
            x_forwarded_for   = lookup(headers.value, "x_forwarded_for", [])
            x_forwarded_host  = lookup(headers.value, "x_forwarded_host", [])
          }
        }

        ip_address                = lookup(ip_restriction.value, "ip_address", null)
        name                      = lookup(ip_restriction.value, "name", null)
        priority                  = lookup(ip_restriction.value, "priority", null)
        service_tag               = lookup(ip_restriction.value, "service_tag", null)
        virtual_network_subnet_id = lookup(ip_restriction.value, "virtual_network_subnet_id", null)
      }
    }

    load_balancing_mode      = lookup(var.configuration.site_config.value, "load_balancing_mode", null)
    local_mysql_enabled      = lookup(var.configuration.site_config.value, "local_mysql_enabled", null)
    managed_pipeline_mode    = lookup(var.configuration.site_config.value, "managed_pipeline_mode", null)
    minimum_tls_version      = lookup(var.configuration.site_config.value, "minimum_tls_version", null)
    remote_debugging_enabled = lookup(var.configuration.site_config.value, "remote_debugging_enabled", null)
    remote_debugging_version = lookup(var.configuration.site_config.value, "remote_debugging_version", null)

    dynamic "scm_ip_restriction" {
      for_each = lookup(var.configuration.site_config.value, "scm_ip_restriction", {})
      content {
        action = scm_ip_restriction.value.action

        dynamic "headers" {
          for_each = lookup(scm_ip_restriction.value, "headers", {})
          content {
            x_azure_fdid      = lookup(headers.value, "x_azure_fdid", [])
            x_fd_health_probe = lookup(headers.value, "x_fd_health_probe", null)
            x_forwarded_for   = lookup(headers.value, "x_forwarded_for", [])
            x_forwarded_host  = lookup(headers.value, "x_forwarded_host", [])
          }
        }

        ip_address                = lookup(scm_ip_restriction.value, "ip_address", null)
        name                      = lookup(scm_ip_restriction.value, "name", null)
        priority                  = lookup(scm_ip_restriction.value, "priority", null)
        service_tag               = lookup(scm_ip_restriction.value, "service_tag", null)
        virtual_network_subnet_id = lookup(scm_ip_restriction.value, "virtual_network_subnet_id", null)
      }
    }

    scm_minimum_tls_version     = lookup(var.configuration.site_config.value, "scm_minimum_tls_version", null)
    scm_use_main_ip_restriction = lookup(var.configuration.site_config.value, "scm_use_main_ip_restriction", null)
    use_32_bit_worker           = lookup(var.configuration.site_config.value, "use_32_bit_worker", null)
    vnet_route_all_enabled      = lookup(var.configuration.site_config.value, "vnet_route_all_enabled", null)
    websockets_enabled          = lookup(var.configuration.site_config.value, "websockets_enabled", null)
    worker_count                = lookup(var.configuration.site_config.value, "worker_count", null)
  }

  app_settings = try(var.app_settings, null)

  dynamic "auth_settings" {
    for_each = lookup(var.configuration.value, "auth_settings", null)

    content {
      enabled = auth_settings.value.enabled

      dynamic "active_directory" {
        for_each = lookup(auth_settings.value, "active_directory", null)

        content {
          client_id                  = active_directory.value.client_id
          allowed_audiences          = try(active_directory.value.allowed_audiences, null)
          client_secret              = try(active_directory.value.client_secret, null)
          client_secret_setting_name = try(active_directory.value.client_secret_setting_name, null)
        }
      }

      additional_login_parameters    = try(auth_settings.value.additional_login_parameters, null)
      allowed_external_redirect_urls = try(auth_settings.value.allowed_external_redirect_urls, null)
      default_provider               = try(auth_settings.value.default_provider, null)

      dynamic "facebook" {
        for_each = lookup(auth_settings.value, "facebook", null)

        content {
          app_id                  = facebook.value.app_id
          app_secret              = try(facebook.value.app_secret, null)
          app_secret_setting_name = try(facebook.value.app_secret_setting_name, null)
          oauth_scopes            = try(facebook.value.oauth_scopes, null)
        }
      }

      dynamic "github" {
        for_each = lookup(auth_settings.value, "github", null)

        content {
          client_id                  = github.value.client_id
          client_secret              = try(github.value.client_secret, null)
          client_secret_setting_name = try(github.value.client_secret_setting_name, null)
          oauth_scopes               = try(github.value.oauth_scopes, null)
        }
      }

      dynamic "google" {
        for_each = lookup(auth_settings.value, "google", null)

        content {
          client_id                  = google.value.client_id
          client_secret              = try(google.value.client_secret, null)
          client_secret_setting_name = try(google.value.client_secret_setting_name, null)
          oauth_scopes               = try(google.value.oauth_scopes, null)
        }
      }

      issuer = try(auth_settings.value.issuer, null)

      dynamic "microsoft" {
        for_each = lookup(auth_settings.value, "microsoft", null)

        content {
          client_id                  = microsoft.value.client_id
          client_secret              = try(microsoft.value.client_secret, null)
          client_secret_setting_name = try(microsoft.value.client_secret_setting_name, null)
          oauth_scopes               = try(microsoft.value.oauth_scopes, null)
        }
      }

      runtime_version               = try(auth_settings.value.runtime_version, null)
      token_refresh_extension_hours = try(auth_settings.value.token_refresh_extension_hours, null)
      token_store_enabled           = try(auth_settings.value.token_store_enabled, null)

      dynamic "twitter" {
        for_each = lookup(auth_settings.value, "twitter", null)

        content {
          consumer_key                 = twitter.value.consumer_key
          consumer_secret              = try(twitter.value.consumer_secret, null)
          consumer_secret_setting_name = try(twitter.value.consumer_secret_setting_name, null)
        }
      }

      unauthenticated_client_action = try(auth_settings.value.unauthenticated_client_action, null)
    }
  }

  dynamic "backup" {
    for_each = lookup(var.configuration.value, "backup", {})

    content {
      name = backup.value.name

      dynamic "schedule" {
        for_each = backup.value.schedule
        content {
          frequency_interval       = schedule.value.frequency_interval
          frequency_unit           = schedule.value.frequency_unit
          keep_at_least_one_backup = schedule.value.keep_at_least_one_backup
          retention_period_days    = schedule.value.retention_period_days
          start_time               = schedule.value.start_time
        }
      }

      storage_account_url = backup.value.storage_account_url
      enabled             = backup.value.enabled
    }
  }

  client_affinity_enabled    = try(var.client_affinity_enabled, null)
  client_certificate_enabled = try(var.client_certificate_enabled, null)
  client_certificate_mode    = try(var.client_certificate_mode, null)
  # client_certificate_exclusion_paths = var.client_certificate_exclusion_paths # https://github.com/hashicorp/terraform-provider-azurerm/blob/main/CHANGELOG.md#3280-october-20-2022

  dynamic "connection_string" {
    for_each = lookup(var.configuration.value, "connection_string", {})

    content {
      name  = var.configuration.connection_string.value.name
      type  = var.configuration.connection_string.value.type
      value = var.configuration.connection_string.value.value
    }
  }

  enabled    = try(var.enabled, null)
  https_only = try(var.https_only, null)

  dynamic "identity" {
    for_each = lookup(var.configuration.value, "identity", {})

    content {
      type         = identity.value.type
      identity_ids = identity.value.managed_identities
    }
  }

  key_vault_reference_identity_id = try(var.key_vault_reference_identity_id, null)

  dynamic "logs" {
    for_each = lookup(var.configuration.value, "logs", {})

    content {
      dynamic "application_logs" {
        for_each = logs.value.application_logs
        content {
          dynamic "azure_blob_storage" {
            for_each = application_logs.value.azure_blob_storage
            content {
              level             = azure_blob_storage.value.level
              retention_in_days = azure_blob_storage.value.retention_in_days
              sas_url           = azure_blob_storage.value.sas_url
            }
          }
          file_system_level = azure_blob_storage.value.file_system_level
        }
      }

      detailed_error_messages = logs.value.detailed_error_messages
      failed_request_tracing  = logs.value.failed_request_tracing

      dynamic "http_logs" {
        for_each = logs.value.http_logs
        content {
          dynamic "azure_blob_storage" {
            for_each = http_logs.value.azure_blob_storage
            content {
              # level             = azure_blob_storage.value.level # Note: this field is not available for `http_logs` block.
              retention_in_days = azure_blob_storage.value.retention_in_days
              sas_url           = azure_blob_storage.value.sas_url
            }
          }

          dynamic "file_system" {
            for_each = http_logs.value.file_system
            content {
              retention_in_days = file_system.value.retention_in_days
              retention_in_mb   = file_system.value.retention_in_mb
            }
          }
        }
      }
    }
  }

  dynamic "storage_account" {
    for_each = lookup(var.configuration.value, "storage_account", {})

    content {
      access_key   = storage_account.value.access_key   # (Required) The Access key for the storage account.
      account_name = storage_account.value.account_name # (Required) The Name of the Storage Account.
      name         = storage_account.value.name         # (Required) The name which should be used for this Storage Account.
      share_name   = storage_account.value.share_name   # (Required) The Name of the File Share or Container Name for Blob storage.
      type         = storage_account.value.type         # (Required) The Azure Storage Type. Possible values include `AzureFiles` and `AzureBlob`.
      mount_path   = storage_account.value.mount_path   # (Optional) The path at which to mount the storage share.
    }
  }

  dynamic "sticky_settings" {
    for_each = lookup(var.configuration.value, "sticky_settings", {})

    content {
      app_setting_names       = sticky_settings.value.app_setting_names
      connection_string_names = sticky_settings.value.connection_string_names
    }
  }

  virtual_network_subnet_id = try(var.virtual_network_subnet_id, null)
  zip_deploy_file           = try(var.zip_deploy_file, null)

  tags = try(var.tags, null)
}
