locals {
    location = "northeurope"
  
}

# Generate a random integer to create a globally unique name
resource "random_integer" "ri" {
  min = 10000
  max = 99999
}

# Generate a random integer to create a globally unique name
resource "random_integer" "func" {
  min = 10000
  max = 99999
}