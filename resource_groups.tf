resource "azurerm_resource_group" "smart1-cp-gw-rg" {
  name = "cp-gw-rg"
  location = "West US 2"
}

resource "azurerm_resource_group" "smart1-cp-vm-rg" {
  name = "cp-vm-rg"
  location = "West US 2"
}