terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.43.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  subscription_id = "4414020d-454a-4759-ab50-979f6260184a"
  tenant_id = "55e6ecb4-fd5f-49c6-bcd5-368a035ffbcd"
  client_id = "65a86352-04dd-46f5-aea4-b50fb01a476c"
  client_secret = "xzq8Q~dadKi11mkX_hFZmb-04~eo_918Ijf~La9r"
  features {}
    
  }