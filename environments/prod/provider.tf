terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.41.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "todo-app-0075"
    storage_account_name = "todoapp0075"
    container_name       = "todoapp0075"
    key                  = "prod.tfstate"
  }
}

provider "azurerm" {
  features {}
  subscription_id =  "06f4c176-e41e-424a-bfc2-cb4b3a4e5fe5"
}
