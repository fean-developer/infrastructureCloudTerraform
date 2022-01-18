    
    terraform  {
        required_providers {
            azurerm = {
                source = "hashicorp/azurerm"
                version = "~>2.0"
            }
        }
    }

    provider "azurerm" {
        features {}
    }

    # Create a resource group in the azure
    resource "azurerm_resource_group" "rg_work_ic_arq" {
        name = "rg_work_ic_arq"
        location = "West Europe"
    }
