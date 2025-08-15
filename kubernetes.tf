# Cluster Kubernetes avec ton prénom
resource "scaleway_k8s_cluster" "main" {
  name    = "${var.project_name}-${var.student_name}-cluster"
  version = "1.32.3"
  cni     = "cilium"
  
  private_network_id = scaleway_vpc_private_network.main.id
  delete_additional_resources = true
  
  tags = [
    "project:${var.project_name}",
    "student:${var.student_name}",
    "environment:dev",
    "managed-by:terraform"
  ]
}

# Pool de nœuds avec ton prénom
resource "scaleway_k8s_pool" "main" {
  cluster_id = scaleway_k8s_cluster.main.id
  name       = "${var.project_name}-${var.student_name}-pool"
  node_type  = "DEV1-L"
  size       = 1
  
  min_size = 1
  max_size = 3
  
  autohealing = true
  autoscaling = true
  
  tags = [
    "project:${var.project_name}",
    "student:${var.student_name}",
    "environment:dev",
    "managed-by:terraform"
  ]
}

resource "scaleway_k8s_pool" "main_pool" {
  cluster_id = scaleway_k8s_cluster.main.id
  name       = "main-pool"
  node_type  = "DEV1-M" # ou un autre type de nœud selon ton budget
  size       = 1
  autoscaling = false
  tags       = ["devops", "wordpress"]
}

# Ressource pour stocker le kubeconfig
resource "null_resource" "kubeconfig" {
  depends_on = [scaleway_k8s_pool.main]
  
  triggers = {
    host                   = scaleway_k8s_cluster.main.kubeconfig[0].host
    token                  = scaleway_k8s_cluster.main.kubeconfig[0].token
    cluster_ca_certificate = scaleway_k8s_cluster.main.kubeconfig[0].cluster_ca_certificate
  }
}