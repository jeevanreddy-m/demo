
/*provider "azuread"{
  tenant_id = var.tenant_id
  client_id = var.client_id
  client_secret = var.client_secret
}

provider "azurerm" {
  subscription_id = var.aa-subscription-id
  tenant_id = var.tenant_id
  client_id = var.client_id
  client_secret = var.client_secret
  features {
  }
}
*/
##########################################################
#Resource group Creation
##########################################################
resource "azurerm_resource_group" "rg" {
  #name     = "aa-${var.aa-vertical}-${var.aa-application}-${var.aa-sdlc-environment}-${var.aa-location}-rg"
  name     = "github-terraform-rg1"
  location = var.aa_location
  /*
  tags = {
    aa-app-id           = var.aa-app-id
    aa-costcenter       = var.aa-costcenter
    aa-application      = var.aa-application
    aa-sdlc-environment = var.aa-sdlc-environment
    aa-vertical         = var.aa-vertical
    aa-location         = var.aa-location
    aa-app-shortname    = var.aa-shortname
  }

}

##########################################################
#Owner role assignment
##########################################################

resource "azurerm_role_assignment" "role" {
  count               = var.aa-rg-own-oid != "" ? 1 : 0
  scope                = azurerm_resource_group.rg.id
  role_definition_name = "Owner"
  principal_id         = var.aa-rg-own-oid
}

############################################################

resource "azurerm_role_assignment" "sp-contributor" {
  count               = var.spnid != "" ? 1 : 0
  scope                = azurerm_resource_group.rg.id
  role_definition_name = "Contributor"
  principal_id         = var.spnid
}

resource "azurerm_role_assignment" "gr-owner" {
  count               = var.owner-group-id != "" ? 1 : 0
  scope                = azurerm_resource_group.rg.id
  role_definition_name = "Owner"
  principal_id         = var.owner-group-id
}

resource "azurerm_role_assignment" "gr-contributor" {
  count               = var.contrib-group-id != "" ? 1 : 0
  scope                = azurerm_resource_group.rg.id
  role_definition_name = "Contributor"
  principal_id         = var.contrib-group-id
}

resource "azurerm_role_assignment" "gr-reader" {
  count               = var.reader-group-id != "" ? 1 : 0
  scope                = azurerm_resource_group.rg.id
  role_definition_name = "AA-Reader+"
  principal_id         = var.reader-group-id
}

resource "azurerm_role_assignment" "gr-viewer" {
  count               = var.viewer-group-id != "" ? 1 : 0
  scope                = azurerm_resource_group.rg.id
  role_definition_name = "AA-Viewer"
  principal_id         = var.viewer-group-id
}

}
 */
}