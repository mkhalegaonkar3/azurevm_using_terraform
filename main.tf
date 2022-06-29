resource "azurerm_resource_group" "demoRG" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "demoVnet" {
  name                = var.vnet_name
  resource_group_name = azurerm_resource_group.demoRG.name
  location            = azurerm_resource_group.demoRG.location
  # to make dual stack vnet add ipv6 address space brlow
  address_space = ["10.0.0.0/16", "ace:cab:deca::/48"]
  tags = {
    environment = var.environment
  }

}
resource "azurerm_subnet" "demo-subnet" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.demoRG.name
  virtual_network_name = azurerm_virtual_network.demoVnet.name
  address_prefixes     = [var.subnet_address_prefixes]
}
resource "azurerm_public_ip" "public_ip" {
  name                = "vm_public_ip"
  resource_group_name = azurerm_resource_group.demoRG.name
  location            = azurerm_resource_group.demoRG.location
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "demoNic" {
  name                = var.nic_name
  location            = azurerm_resource_group.demoRG.location
  resource_group_name = azurerm_resource_group.demoRG.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.demo-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }
}
resource "azurerm_network_security_group" "demonsg" {
  name                = "ssh_nsg"
  location            = azurerm_resource_group.demoRG.location
  resource_group_name = azurerm_resource_group.demoRG.name

  security_rule {
    name                       = "allow_ssh_sg"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
resource "azurerm_network_interface_security_group_association" "demo-association" {
  network_interface_id      = azurerm_network_interface.demoNic.id
  network_security_group_id = azurerm_network_security_group.demonsg.id
}

resource "azurerm_linux_virtual_machine" "demo-linux-vm" {
  name                = "demo-linux-vm"
  resource_group_name = azurerm_resource_group.demoRG.name
  location            = azurerm_resource_group.demoRG.location
  size                = var.size
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  # When an admin_password is specified disable_password_authentication must be set to false. ~> NOTE: One of either admin_password or admin_ssh_key must be specified.
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.demoNic.id,
  ]

  os_disk {
    caching              = var.caching
    storage_account_type = var.storage_account_type
  }
  source_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.sku
    version   = var.os_version
  }
}
