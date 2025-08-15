output "cluster_id" {
  description = "ID du cluster Kubernetes"
  value       = scaleway_k8s_cluster.main.id
}

output "cluster_name" {
  description = "Nom du cluster"
  value       = scaleway_k8s_cluster.main.name
}

output "student_name" {
  description = "Nom de l'étudiant"
  value       = var.student_name
}

output "cluster_status" {
  description = "Statut du cluster"
  value       = scaleway_k8s_cluster.main.status
}

output "kubeconfig" {
  description = "Configuration kubectl"
  value       = scaleway_k8s_cluster.main.kubeconfig[0]
  sensitive   = true
}

output "load_balancer_ip" {
  description = "IP du Load Balancer"
  value       = try(data.kubernetes_service.ingress_nginx.status[0].load_balancer[0].ingress[0].ip, "En attente...")
}

output "wordpress_url" {
  description = "URL de WordPress"
  value       = "http://${var.wordpress_domain}"
}

output "wordpress_admin" {
  description = "Informations d'administration WordPress"
  value = {
    username = "admin"
    password = "ChangeMe123-${var.student_name}!"
    email    = "admin-${var.student_name}@example.com"
  }
  sensitive = true
}

output "project_summary" {
  description = "Résumé du projet"
  value = {
    student      = var.student_name
    project_name = var.project_name
    cluster_name = scaleway_k8s_cluster.main.name
    domain       = var.wordpress_domain
  }
}