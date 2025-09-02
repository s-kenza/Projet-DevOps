
resource "kubernetes_namespace" "wordpress" {
  depends_on = [null_resource.kubeconfig]
  
  metadata {
    name = "wordpress-${var.student_name}"
    labels = {
      "app.kubernetes.io/name"     = "wordpress"
      "app.kubernetes.io/instance" = "wordpress-${var.student_name}"
      "student"                    = var.student_name
    }
  }
}

resource "helm_release" "wordpress" {
  depends_on = [helm_release.ingress_nginx, kubernetes_namespace.wordpress]
  
  name       = "wordpress-${var.student_name}"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "wordpress"
  namespace  = kubernetes_namespace.wordpress.metadata[0].name
  version    = "18.0.0"
  
  set {
    name  = "wordpressUsername"
    value = "admin"
  }
  
  set {
    name  = "wordpressPassword"
    value = "ChangeMe123-${var.student_name}!"
  }
  
  set {
    name  = "wordpressEmail"
    value = "admin-${var.student_name}@example.com"
  }
  
  set {
    name  = "wordpressFirstName"
    value = "Super"
  }
  
  set {
    name  = "wordpressLastName"
    value = var.student_name
  }
  
  set {
    name  = "service.type"
    value = "ClusterIP"
  }
  
  set {
    name  = "ingress.enabled"
    value = "true"
  }
  
  set {
    name  = "ingress.ingressClassName"
    value = "nginx"
  }
  
  set {
    name  = "ingress.hostname"
    value = var.wordpress_domain
  }
  
  set {
    name  = "ingress.annotations.kubernetes\\.io/ingress\\.class"
    value = "nginx"
  }
  
  set {
    name  = "mariadb.enabled"
    value = "true"
  }
  
  set {
    name  = "mariadb.auth.rootPassword"
    value = "RootPassword123-${var.student_name}!"
  }
  
  set {
    name  = "mariadb.auth.database"
    value = "wordpress_${replace(var.student_name, "-", "_")}"
  }
  
  set {
    name  = "mariadb.auth.username"
    value = "wp_${replace(var.student_name, "-", "_")}"
  }
  
  set {
    name  = "mariadb.auth.password"
    value = "WordPressPassword123-${var.student_name}!"
  }
  
  set {
    name  = "resources.requests.memory"
    value = "512Mi"
  }
  
  set {
    name  = "resources.requests.cpu"
    value = "300m"
  }
  
  set {
    name  = "persistence.enabled"
    value = "false"
  }
  
  wait          = true
  wait_for_jobs = true
  timeout       = 600
  
  skip_crds = true
}