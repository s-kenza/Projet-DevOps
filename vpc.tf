# VPC avec ton prénom
resource "scaleway_vpc" "main" {
  name = "${var.project_name}-${var.student_name}-vpc"
  
  tags = [
    "project:${var.project_name}",
    "student:${var.student_name}",
    "environment:dev",
    "managed-by:terraform"
  ]
}

# Réseau privé avec ton prénom
resource "scaleway_vpc_private_network" "main" {
  name   = "${var.project_name}-${var.student_name}-private-network"
  vpc_id = scaleway_vpc.main.id
  
  tags = [
    "project:${var.project_name}",
    "student:${var.student_name}",
    "environment:dev",
    "managed-by:terraform"
  ]
}

# Passerelle publique avec ton prénom
resource "scaleway_vpc_public_gateway" "main" {
  name = "${var.project_name}-${var.student_name}-gateway"
  type = "VPC-GW-S"
  
  tags = [
    "project:${var.project_name}",
    "student:${var.student_name}",
    "environment:dev",
    "managed-by:terraform"
  ]
}

# Connexion de la passerelle au réseau privé
resource "scaleway_vpc_gateway_network" "main" {
  gateway_id         = scaleway_vpc_public_gateway.main.id
  private_network_id = scaleway_vpc_private_network.main.id
  ipam_config {
    push_default_route = true
  }
}