terraform {
  backend "azurerm" {
    resource_group_name  = "github-terraform-rg1"
    storage_account_name = "storagegithubtf"
    container_name       = "tfstatefile"
    key                  = "dev.terraform.tfstate"
  }
}
# module "RG" {
#   source   = "./modules/RG" #A
#   rgname   = var.rgname     #B
#   location = var.location
# }

/* resource "azurerm_resource_group" "rg" {
  name     = "github-terraform-rg1"
  location = "East US"
}


# module "SA" {
#   source   = "./modules/StorageAccount"
#   sname    = var.sname
#   rgname   = var.rgname
#   location = var.location
# }

resource "azurerm_storage_account" "STA" {
  name                     = "storagegithubtf"
  resource_group_name      = "github-terraform-rg1"
  location                 = "East US"
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "dev"
  }
  depends_on = [
      azurerm_resource_group.rg
    ]
} */

module "RG" {
    source   = "./modules/RG" #A
  rgname   = "extra-rg"    #B
  location = var.location
 }