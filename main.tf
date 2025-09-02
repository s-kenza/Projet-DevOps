
locals {
  common_tags = [
    "project:${var.project_name}",
    "student:${var.student_name}",
    "environment:dev",
    "managed-by:terraform",
    "school:esgi",
    "group:grp_7"
  ]
}

resource "null_resource" "welcome" {
  provisioner "local-exec" {
    command = <<-EOT
      echo "Démarrage du déploiement ${var.project_name} pour ${var.student_name}"
      echo "Région: ${var.region}"
      echo "Zone: ${var.zone}"
      echo "Domaine: ${var.wordpress_domain}"
      echo "Étudiant: ${var.student_name}"
      echo "Groupe: grp_7"
    EOT
  }
}