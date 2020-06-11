#Gateway NSG
resource "azurerm_network_security_group" "cp-gw-nsg" {
  depends_on=[azurerm_resource_group.smart1-cp-gw-rg]
  name = "cp-gw-nsg"
  location            = azurerm_resource_group.smart1-cp-gw-rg.location
  resource_group_name = azurerm_resource_group.smart1-cp-gw-rg.name
  security_rule {
    name                       = "Any"
    description                = "Any"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }

  tags = {
    environment = var.environment
  }
}



#VM NSG
resource "azurerm_network_security_group" "cp-vm-nsg" {
  depends_on=[azurerm_resource_group.smart1-cp-vm-rg]
  name = "cp-vm-nsg"
  location            = azurerm_resource_group.smart1-cp-vm-rg.location
  resource_group_name = azurerm_resource_group.smart1-cp-vm-rg.name
  security_rule {
    name                       = "allow-ssh"
    description                = "allow-ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "allow-http"
    description                = "allow-http"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }
  tags = {
    environment = var.environment
  }
}