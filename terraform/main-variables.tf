variable "tenant_id" {
  description = "Tenant ID for American Airlines account in Azure Active Directory."
}
variable "subscription_id" {
  description = "The Azure Subscription ID."
}
variable "subscription_ba_id" {
  description = "The Azure Subscription ID for BA Team"
  sensitive = true
}
variable "client_id" {
  description = "The client id of Service Principal. Used for connecting to Azure."
}
variable "client_secret" {
  description = "The client secret of Service Principal. Used for connecting to Azure."
}
/*variable "rg_name" {
  description = "Resource group name to use/create."
  type = string
  default = null
}
variable "rg_env" {
  description = "Resource group environment (e.g. dev)."
  default="dev"
}
variable "rg_region" {
  description = "Resource group region (e.g. east)."
  default="east"
}
variable "name_prefix" {
  description = "The unique name prefix for the resources being created."
  type = string
  default = null
}
variable "name_suffix" {
  description = "The unique name suffix for the resources being created."
  type = string
  default = null
}
variable "aa-subscription-id" {
  description = "g1"
  default = null
}

variable "aa-tenant-id" {
  description = "g1"
  default = null
}

variable "aa-rg-owner" {
  description = "The corpaa user id of the Resource Group Owner Ex: 123456@corpaa.aa.com"
  default = null
}

variable "aa-rg-own-oid" {
  description = "The object ID of the user specified inthe aa-rg-owner variable"
  type = string
  default = null
}

variable "aa-app-id" {
  description = "The application Archer ID from aagrc.aa.com"
  type = string
  default = null
}
variable "aa-costcenter" {
  description = "The application costcenter Ex: 0900/1234"
  type = string
  default = null
}

variable "aa-application" {
  description = "The application name"
  default = null
}*/

variable "aa_location" {
  description = "The Azure region. Ex: centralus or eastus"
}

/*variable "aa-sdlc-environment" {
  description = "The Environment dev, test, stage, prod, prod-a, prod-b"
  default = "dev"
}

variable "aa-vertical" {
  description = "The vertical. Ex: aot"
  type = string
  default = null
}

variable "aa-security" {
  description = "Tag is currently reserved for IT Security. Not in use yet"
  type = string
  default = null
}

variable "aa-shortname" {
  description = "The shortname for the application as listed in Archer"
  type = string
  default = null
}
variable "spnid" {
  type = string
  default = null
}
variable "owner-group-id" {
  type = string
  default = null
}
variable "contrib-group-id" {
  type = string
  default = null
}
variable "reader-group-id" {
  type = string
  default = null
}
variable "viewer-group-id" {
  type = string
  default = null
}*/