variable "subscription_id" {
  default = "f8401d22-c3b5-4f82-87d1-ccb61ef5b737"
}
variable "tenant_id" {
  default = "58dea911-047d-43fb-9342-19ca17665d67"
}

variable "client_id" {
  default = "b234a288-6647-4c89-af9e-55c929e01009"
}
variable "client_secret" {
  default = "vdD8Q~71wBBP1tfTdrfb4FN.B5Et3CWfjRad.dBH"
}
variable "location" {
  default = "Central US"
}

variable "resource_group_name" {
  default = "demo-resource-group"
}

variable "vnet_name" {
  default = "demo-vnet"
}

variable "nic_name" {
  default = "demo-nic"
}
variable "environment" {
  default = "demo"
}

variable "subnet_address_prefixes" {
  default = "10.0.2.0/24"
}
variable "size" {
  default = "Standard_DS1"
}
variable "caching" {
  default = "ReadWrite"
}

variable "storage_account_type" {
  default = "Standard_LRS"
}

variable "admin_username" {
  default = "adminuser"
}
variable "admin_password" {
  default = "admin@123456"
}

variable "publisher" {
  default = "Canonical"
}

variable "offer" {
  default = "UbuntuServer"
}

variable "sku" {
  default = "16.04-LTS"
}

variable "os_version" {
  default = "latest"
}
