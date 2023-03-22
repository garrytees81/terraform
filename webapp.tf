resource "azurerm_resource_group" "rg" {
  name     = "apprg-${random_integer.ri.result}"
  location = local.location
  } 

resource"azurerm_service_plan" "WebAppPlan1" {
  name                = "webapp-asp-${random_integer.ri.result}"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  os_type = "Linux"
  sku_name = "F1"
    depends_on = [
      azurerm_resource_group.rg
    ]
}

resource "azurerm_linux_web_app" "webapp1" {
    name = "webapp-${random_integer.ri.result}"
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    service_plan_id = azurerm_service_plan.WebAppPlan1.id
    https_only            = true
  
    depends_on = [
    azurerm_service_plan.WebAppPlan1
  ]
  
  site_config {
    always_on = false
    minimum_tls_version = "1.2"
    application_stack {
      node_version = "18-lts"
          }

    }
}

#  Deploy code from a public GitHub repo
resource "azurerm_app_service_source_control" "sourcecontrol" {
  app_id             = azurerm_linux_web_app.webapp1.id
  repo_url           = "https://github.com/garrytees81/webapp1"
  branch             = "main"
  use_manual_integration = true
  use_mercurial      = false
  depends_on = [
    azurerm_linux_web_app.webapp1
  ]
}
