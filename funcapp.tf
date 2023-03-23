resource "azurerm_resource_group" "rg1" {
  name     = "apprg-${random_integer.func.result}"
  location = local.location
  } 

resource "azurerm_storage_account" "funappblob1" {
  name                     = "funcapp-blob-${random_integer.func.result}"
  resource_group_name      = azurerm_resource_group.rg1.name
  location                 = azurerm_resource_group.rg1.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  depends_on = [
    azurerm_resource_group.rg1
  ]
}

resource "azurerm_service_plan" "funcappasp" {
  name                = "funcapp-asp-${random_integer.func.result}"
  resource_group_name = azurerm_resource_group.rg1.name
  location            = azurerm_resource_group.rg1.location
  os_type             = "Linux"
  sku_name            = "F1"

   depends_on = [
    azurerm_resource_group.rg1
  ]
}


resource "azurerm_linux_function_app" "funcapp1" {
  name                = "funcapp-${random_integer.func.result}"
 resource_group_name = azurerm_resource_group.rg1.name
  location            = azurerm_resource_group.rg1.location

  storage_account_name       = azurerm_storage_account.funappblob1.name
  storage_account_access_key = azurerm_storage_account.funappblob1.primary_access_key
  service_plan_id            = azurerm_service_plan.funcappasp.id

  site_config {

    application_stack {
      python_version = "3.7"
          }
  }

   depends_on = [
    azurerm_resource_group.rg1,azurerm_service_plan.funcappasp
  ]
}
