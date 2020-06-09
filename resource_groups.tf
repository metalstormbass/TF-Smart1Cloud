resource "azurerm_resource_group" "smart1-cp-gw-rg" {
  name = "smart1-cp-gw-rg"
  location = "West US 2"
}

resource "azurerm_resource_group" "smart1-cp-vm-rg" {
  name = "smart1-cp-vm-rg"
  location = "West US 2"
}