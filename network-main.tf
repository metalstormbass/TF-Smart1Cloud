# Create CP GW network VNET
resource "azurerm_virtual_network" "cp-gw-network-vnet" {
  name                = "${var.company}-cp-gw-vnet"
  address_space       = [var.gw-network-vnet-cidr]
  resource_group_name = azurerm_resource_group.cp-gw-rg.name
  location            = azurerm_resource_group.cp-gw-rg.location
  tags = {
    application = var.company
    environment = var.environment
  }
}

# Create CP GW subnet for Network
resource "azurerm_subnet" "cp-gw-subnet" {
  name                 = "${var.company}-cp-gw-subnet"
  address_prefix       = var.gw-network-subnet-cidr
  virtual_network_name = azurerm_virtual_network.cp-gw-network-vnet.name
  resource_group_name  = azurerm_resource_group.cp-gw-rg.name
}

# Create CP GW INTERAL subnet for Network
resource "azurerm_subnet" "cp-gw-internal-subnet" {
  name                 = "${var.company}-cp-gw-internal-subnet"
  address_prefix       = var.gw-network-internal-subnet-cidr
  virtual_network_name = azurerm_virtual_network.cp-gw-network-vnet.name
  resource_group_name  = azurerm_resource_group.cp-gw-rg.name
}