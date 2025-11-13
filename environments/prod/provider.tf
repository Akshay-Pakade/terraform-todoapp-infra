terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.41.0"
    }
  }
     backend "azurerm" {
    resource_group_name  = "test-rg"
    storage_account_name = "teststoragepipelinean"
    container_name       = "akscontainer"
    key                  = "jiokaterraform.tfstate"
  }
}

provider "azurerm" {
  features {}
use_oidc = true
  subscription_id =  "06f4c176-e41e-424a-bfc2-cb4b3a4e5fe5"
}
