

    resource "azurerm_network_interface" "nic_work_ic_arq" {
        name                = "nic_work_ic_arq"
        location            = azurerm_resource_group.rg_work_ic_arq.location
        resource_group_name = azurerm_resource_group.rg_work_ic_arq.name

        ip_configuration {
            name                          = "internal"
            subnet_id                     = azurerm_subnet.subnet_work_ic_arq.id
            private_ip_address_allocation = "Dynamic"
            public_ip_address_id = azurerm_public_ip.ip_work_ic_arq.id
        }
    }

    resource "azurerm_network_interface_security_group_association" "nic_nsg_assoc_work_ic_arq" {
        network_interface_id = azurerm_network_interface.nic_work_ic_arq.id
        network_security_group_id = azurerm_network_security_group.nsg_work_ic_arq.id
    }

    resource "azurerm_linux_virtual_machine" "vm_work_ic_arq" {
        name                  = "vm_work_ic_arq"
        location              = azurerm_resource_group.rg_work_ic_arq.location
        resource_group_name   = azurerm_resource_group.rg_work_ic_arq.name
        network_interface_ids = [
            azurerm_network_interface.nic_work_ic_arq.id
        ]
        size                  = "Standard_F2"
        admin_username        = var.vm_user
        admin_password        = var.vm_password

        os_disk {
            name              = "vmWorkIcArqDisk"
            caching           = "ReadWrite"
            storage_account_type = "Standard_LRS"
        }

        source_image_reference {
            publisher = "Canonical"
            offer     = "UbuntuServer"
            sku       = "18.04-LTS"
            version   = "latest"
        }

        computer_name  = "VMWORKICARQ-001"
        disable_password_authentication = false


        tags = {
            environment = "Production"
        }
    }
