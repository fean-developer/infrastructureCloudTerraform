# Create a veirtual network in the azure
    # This pertences an reource group
    resource "azurerm_virtual_network" "vnet_work_ic_arq" {
        name = "vnet_work_ic_arq"
        location = azurerm_resource_group.rg_work_ic_arq.location
        resource_group_name = azurerm_resource_group.rg_work_ic_arq.name
        address_space = ["10.0.0.0/16"]

        tags = {
            environment = "Production"
            academico = "MBA Infrasctructure Cloud and Architecture"
            faculdade = "Impacta"
        }
    }

    # Create a sub network in the azure 
    # This is dependence of azurerm_virtual_network
    resource "azurerm_subnet" "subnet_work_ic_arq" {
        name = "subnet_work_ic_arq"
        resource_group_name = azurerm_resource_group.rg_work_ic_arq.name
        virtual_network_name = azurerm_virtual_network.vnet_work_ic_arq.name
        address_prefixes = ["10.0.1.0/24"]

    }

    # Create a Public IP in the azure
    resource "azurerm_public_ip" "ip_work_ic_arq" {
      name = "ip_work_ic_arq"
      resource_group_name = azurerm_resource_group.rg_work_ic_arq.name
      location = azurerm_resource_group.rg_work_ic_arq.location
      allocation_method = "Static"

      tags = {
          environment = "Production"
      }
    }

    # Creat a NSG in the azure
    resource "azurerm_network_security_group" "nsg_work_ic_arq" {
        name = "nsg_work_ic_arq"
        location = azurerm_resource_group.rg_work_ic_arq.location
        resource_group_name = azurerm_resource_group.rg_work_ic_arq.name
      
        security_rule {
            name = "SSH"
            priority    = 100
            direction   = "Inbound"
            access      = "Allow"
            protocol    = "TCP"
            source_port_range   = "*"
            destination_port_range  = "22"
            source_address_prefix   = "*"
            destination_address_prefix  = "*"
        }

        tags = {
            environment = "Production"
        }
    }