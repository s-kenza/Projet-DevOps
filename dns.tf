data "scaleway_domain_zone" "main" {
  domain    = "slashops.fr"
  subdomain = "grp-7.esgi"
}

resource "scaleway_domain_record" "wordpress" {
  dns_zone = data.scaleway_domain_zone.main.id
  name     = "@"
  type     = "A"
  data     = data.kubernetes_service.ingress_nginx.status[0].load_balancer[0].ingress[0].ip
  ttl      = 3600
}

# Alternative : Affichage des informations pour configuration manuelle
resource "null_resource" "dns_info" {
  depends_on = [data.kubernetes_service.ingress_nginx]
  
  triggers = {
    load_balancer_ip = try(data.kubernetes_service.ingress_nginx.status[0].load_balancer[0].ingress[0].ip, "pending")
    domain          = var.wordpress_domain
    student         = var.student_name
  }
  
  provisioner "local-exec" {
    command = <<-EOT
      echo "=================================="
      echo "CONFIGURATION DNS POUR ${var.student_name}"
      echo "=================================="
      echo "Nom de domaine: ${var.wordpress_domain}"
      echo "IP Load Balancer: ${self.triggers.load_balancer_ip}"
      echo "Étudiant: ${var.student_name}"
      echo ""
      echo "Crée un enregistrement A:"
      echo "${var.wordpress_domain} -> ${self.triggers.load_balancer_ip}"
      echo ""
      echo "Ou ajoute dans /etc/hosts:"
      echo "${self.triggers.load_balancer_ip} ${var.wordpress_domain}"
      echo "=================================="
    EOT
  }
}