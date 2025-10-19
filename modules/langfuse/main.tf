
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
  repository = "https://langfuse.github.io/langfuse-k8s"
  chart      = "langfuse"

  atomic          = false
  cleanup_on_fail = true
  timeout         = 900

  depends_on = [kind_cluster.default]

  values = [<<EOF
common:
  secrets:
    passwords:
      failOnNew: false
s3:
  auth:
    rootPassword: changeme123
EOF
  ]
}
