# set Terraform required version, and set the required providers
terraform {
  required_providers {
    azuread = {
      source = "hashicorp/azuread"
      version = "~>1.4"
    }
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.46.0"
    }
  }
}