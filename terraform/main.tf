# Configure the Azure Active Directory provider version and service principal credentials
provider "azuread" {
  tenant_id = var.tenant_id
  client_id = var.client_id
  client_secret = var.client_secret
}
# Configure the Azure Resource Manager provider version and service principal credentials
provider "azurerm" {
  features {
  }
  tenant_id = var.tenant_id
  subscription_id = var.subscription_id
  client_id = var.client_id
  client_secret = var.client_secret
}
/*# Configuring the Azure Resource Manager provider version and service principal credentials with different subscription
provider "azurerm" {
  features {}
  alias = "ba"
  tenant_id = var.tenant_id
  subscription_id = var.subscription_ba_id
  client_id = var.client_id
  client_secret = var.client_secret
}*/
resource "resource-group"  rg{
  #source = "git@github.com:AAInternal/terraform.git//azure-modules/resource-group?ref=resource-group-v2.1.0"
  #source   = "./modules/resource-group"
  /*aa-subscription-id = var.aa-subscription-id
  aa-vertical = var.aa-vertical
  aa-application = var.aa-application
  aa-sdlc-environment = var.aa-sdlc-environment
  aa-app-id = var.aa-app-id
  aa-costcenter = var.aa-costcenter
  aa-security = var.aa-security
  aa-rg-owner = var.aa-rg-owner
  aa-rg-own-oid = var.aa-rg-own-oid
  aa-shortname = var.aa-shortname*/
  /*spnid = var.spnid*/
  /*owner-group-id = var.owner-group-id*/
 /* contrib-group-id = var.contrib-group-id*/
  /*reader-group-id = var.reader-group-id*/
/*  tenant_id = var.aa-tenant-id
  client_id = var.client_id
  client_secret = var.client_secret*/
  aa-subscription-id = var.subscription_id
  aa_location = var.aa_location
  tags ={
    app-id= "app123"
  }
}