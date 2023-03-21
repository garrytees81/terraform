resource "azurerm_resource_group" "app-rg-vnet1" {
  name     = local.resource_group_name
  location = local.location
  } 

resource"azurerm_service_plan" "WebAppPlan1" {
  name                = "App_Plan1"
  resource_group_name = local.resource_group_name
  location = local.location
  os_type = "Linux"
  sku_name = "F1"
    depends_on = [
      azurerm_resource_group.app-rg-vnet1
    ]
}


resource "azurerm_linux_web_app" "webapp1" {
    name = "WebApp1gis1981"
    resource_group_name = local.resource_group_name
    location = local.location
    service_plan_id = azurerm_service_plan.WebAppPlan1.id
  depends_on = [
    azurerm_service_plan.WebAppPlan1
  ]
  
  site_config {
    always_on = false
    application_stack {
      node_version = "18-lts"
          }

    }
}



resource"azurerm_service_plan" "WebAppPlan2" {
  name                = "App_Plan2"
  resource_group_name = local.resource_group_name
  location = local.location
  os_type = "Windows"
  sku_name = "F1"
    depends_on = [
      azurerm_resource_group.app-rg-vnet1
    ]
}

resource "azurerm_windows_web_app" "webapp2" {
  name                = "WebApp2gis1982"
  resource_group_name = local.resource_group_name
  location            = local.location
  service_plan_id     = azurerm_service_plan.WebAppPlan2.id

  site_config {
    always_on = false
    application_stack {
      current_stack="dotnet"
      dotnet_version="v6.0"
    }
  }

  depends_on = [
    azurerm_service_plan.WebAppPlan2
  ]
}


resource "azurerm_app_service_source_control" "github2" {
  app_id   = azurerm_windows_web_app.webapp2.id
  repo_url = "https://github.com/garrytees81/webapp2"
  branch   = "master"
  use_manual_integration = true
  
}
