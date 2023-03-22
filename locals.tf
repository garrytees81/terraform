locals {
  resource_group_name = "app-rg-vnet1"
  location = "northeurope"
  
}

# Generate a random integer to create a globally unique name
resource "random_integer" "ri" {
  min = 10000
  max = 99999
}