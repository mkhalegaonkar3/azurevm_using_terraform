output "subnet-id" {
  value = azurerm_subnet.demo-subnet.id
  
}
output "public_ip" {
  value = azurerm_public_ip.public_ip.ip_address
}
