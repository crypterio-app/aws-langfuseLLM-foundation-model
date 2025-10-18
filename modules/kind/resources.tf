
data "external" "subnet" {
  program = ["/bin/bash", "-c", "docker network inspect -f '{{json .IPAM.Config}}' kind | jq .[0]"]
  depends_on = [
    kind_cluster.default
  ]
}

provider "helm" {
  kubernetes {
    config_path = pathexpand(var.kind_cluster_config_path)
  }
}

resource "helm_release" "langfuse" {
  name       = "langfuse"
  namespace  = "langfuse"
  repository = "https://langfuse.github.io/langfuse-k8s"  # official Helm repo
  chart      = "langfuse"
  #version    = "3.27.6"  # replace with latest stable version

  atomic           = false   # prevents automatic rollback on timeout
  cleanup_on_fail  = true
  timeout          = 900     # 15 min, Airflow may take long to deploy
  depends_on = [kind_cluster.default]
}


