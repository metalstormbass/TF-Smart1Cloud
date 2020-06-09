#CP GW NICS
resource "azurerm_network_interface" "cp-gw-external" {
    name                = "cp-gw-external"
    location            = azurerm_resource_group.smart1-cp-gw-rg.location
    resource_group_name = azurerm_resource_group.smart1-cp-gw-rg.name
    enable_ip_forwarding = "true"
	ip_configuration {
        name                          = "cp-gw-public-ip-config"
        subnet_id                     = azurerm_subnet.cp-gw-subnet.id
        private_ip_address_allocation = "Static"
		private_ip_address = "10.10.0.10"
        primary = true
		public_ip_address_id = azurerm_public_ip.cp-gw-public-ip.id
    }
}

resource "azurerm_network_interface" "cp-gw-internal" {
    name                = "cp-gw-internal"
    location            = azurerm_resource_group.smart1-cp-gw-rg.location
    resource_group_name = azurerm_resource_group.smart1-cp-gw-rg.name
    enable_ip_forwarding = "true"
	ip_configuration {
        name                          = "cp-gw-internal-config"
        subnet_id                     = azurerm_subnet.cp-gw-internal-subnet.id
        private_ip_address_allocation = "Static"
		private_ip_address = "10.10.1.10"
    }
}

#Associate Security Group with Internface

resource "azurerm_network_interface_security_group_association" "cp-gw-nsg-int" {
  network_interface_id      = azurerm_network_interface.cp-gw-external.id
  network_security_group_id = azurerm_network_security_group.cp-gw-nsg.id
  }
resource "azurerm_network_interface_security_group_association" "cp-gw-nsg-int2" {
  network_interface_id      = azurerm_network_interface.cp-gw-internal.id
  network_security_group_id = azurerm_network_security_group.cp-gw-nsg.id
  }


#CP GW Virtual Machine
resource "azurerm_virtual_machine" "cp-gw" {
    name                  = "${var.company}-cp-gw"
    location              = azurerm_resource_group.smart1-cp-gw-rg.location
    resource_group_name   = azurerm_resource_group.smart1-cp-gw-rg.name
    network_interface_ids = [azurerm_network_interface.cp-gw-external.id,azurerm_network_interface.cp-gw-internal.id]
    primary_network_interface_id = azurerm_network_interface.cp-gw-external.id
    vm_size               = "Standard_D4s_v3"
    
    storage_os_disk {
        name              = "cp-gw-disk"
        caching           = "ReadWrite"
        create_option     = "FromImage"
        managed_disk_type = "Standard_LRS"
    }

    storage_image_reference {
        publisher = "checkpoint"
        offer     = "check-point-cg-r8040"
        sku       = "sg-byol"
        version   = "latest"
    }

    plan {
        name = "sg-byol"
        publisher = "checkpoint"
        product = "check-point-cg-r8040"
        }
    
#Need to fix passing varible to gw-bootstrap.sh. Currently requires var to be hardcoded in file

    os_profile {
        computer_name  = "${var.company}-cp-gw"
        admin_username = "azureuser"
        admin_password = "Vpn123vpn123!"
        custom_data = templatefile("./gw-bootstrap.sh",{
            sic_key=var.sic_key
            }
        ) 
    }

    os_profile_linux_config {
        disable_password_authentication = false
    }

    boot_diagnostics {
        enabled = "true"
        storage_uri = azurerm_storage_account.cp-gw-storage-account.primary_blob_endpoint
    }

}
