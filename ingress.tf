# Namespace pour Nginx Ingress avec ton prénom
resource "kubernetes_namespace" "ingress_nginx" {
  depends_on = [null_resource.kubeconfig]
  
  metadata {
    name = "ingress-nginx-${var.student_name}"
    labels = {
      "app.kubernetes.io/name"     = "ingress-nginx"
      "app.kubernetes.io/instance" = "ingress-nginx-${var.student_name}"
      "student"                    = var.student_name
    }
  }
}

# Déploiement du contrôleur Ingress Nginx avec nom personnalisé
resource "helm_release" "ingress_nginx" {
  depends_on = [kubernetes_namespace.ingress_nginx]
  
  name       = "ingress-nginx-${var.student_name}"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  namespace  = kubernetes_namespace.ingress_nginx.metadata[0].name
  version    = "4.8.0"
  
  set {
    name  = "controller.service.type"
    value = "LoadBalancer"
  }
  
  set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/scw-loadbalancer-type"
    value = "LB-S"
  }
  
  # Nom personnalisé pour le Load Balancer
  set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/scw-loadbalancer-name"
    value = "${var.project_name}-${var.student_name}-lb"
  }
  
  wait          = true
  wait_for_jobs = true
  timeout       = 600
}

# Récupération de l'IP du Load Balancer
data "kubernetes_service" "ingress_nginx" {
  depends_on = [helm_release.ingress_nginx]
  
  metadata {
    name      = "ingress-nginx-${var.student_name}-controller"
    namespace = kubernetes_namespace.ingress_nginx.metadata[0].name
  }
}