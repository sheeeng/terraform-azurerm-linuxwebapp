resource "azurerm_key_vault" "bad_example" {
  name                        = "examplekeyvault"
  location                    = azurerm_resource_group.bad_example.location
  enabled_for_disk_encryption = true
  purge_protection_enabled    = false
}

resource "azurerm_key_vault_key" "bad_example" {
  name         = "generated-certificate"
  key_vault_id = azurerm_key_vault.bad_example.id
  key_type     = "RSA"
  key_size     = 2048

  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]
}

resource "azurerm_key_vault_secret" "bad_example" {
  name         = "secret-sauce"
  value        = "szechuan"
  key_vault_id = azurerm_key_vault.bad_example.id
}

resource "azurerm_storage_account" "bad_example" {
  name                      = "storageaccountname"
  resource_group_name       = azurerm_resource_group.example.name
  location                  = azurerm_resource_group.example.location
  account_tier              = "Standard"
  account_replication_type  = "GRS"
  enable_https_traffic_only = false
}
