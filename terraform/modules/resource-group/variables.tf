######################################################
#Input Variables
######################################################

variable "aa-subscription-id" {
}
variable "tenant_id" {
}
variable "client_id" {
}
variable "client_secret" {
}

variable "aa-rg-owner" {
  description = "The corpaa user id of the Resource Group Owner Ex: 123456@corpaa.aa.com"
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
}

variable "aa-location" {
  description = "The Azure region. Ex: centralus or eastus"
  default = "eastus"
}

variable "aa-sdlc-environment" {
  description = "The Environment dev, test, stage, prod, prod-a, prod-b"
}

variable "aa-vertical" {
  description = "The vertical. Ex: aot"
}

variable "aa-security" {
  description = "Tag is currently reserved for IT Security. Not in use yet"
  type = string
  default = null
}

variable "aa-shortname" {
  description = "The shortname for the application as listed in Archer"
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
}