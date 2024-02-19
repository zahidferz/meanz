## 

resource "helm_release" "backend" {
  name       = "backend"
  ## We will store charts here but can be stored on s3 on chartmuseum or even OCI on ghcr
  chart      = "../../charts/app"

  set {
    name  = "service.type"
    value = "ClusterIP"
  }

  set {
    name = "image.repository"
    value = "ghcr.io/zahidferz/meanzback"    
  }

  set {
    name  = "fullnameOverride"
    value = "backend"
  }

  depends_on = [ kubernetes_deployment.mongo, kubernetes_service.mongo ]
}


resource "helm_release" "frontend" {
  name       = "frontend"
  ## We will store charts here but can be stored on s3 on chartmuseum or even OCI on ghcr
  chart      = "../../charts/app"

  set {
    name  = "service.type"
    value = "ClusterIP"
  }

  set {
    name = "image.repository"
    value = "ghcr.io/zahidferz/meanzfront"    
  }

  set {
    name  = "fullnameOverride"
    value = "frontend"
  }

}