resource "helm_release" "ngnix" {
    name      = "nginx"
    repository = "https://kubernetes.github.io/ingress-nginx"
    chart     = "ingress-nginx"
    timeout   = 900
    
    set {
      name  = "service.type"
      value = "LoadBalancer"
    }
}

resource "kubernetes_ingress_v1" "meanz" {
  metadata {
    name = "meanz"
    annotations = {
      "kubernetes.io/ingress.class" = "nginx"
    }
  }
  spec {
    ingress_class_name = "nginx"
    rule {
      host = "meanz.club"
      http {
        path {
          path = "/signup"
          path_type = "Exact"
          backend {
            service {
              name = "frontend"
              port {
                number = 80
              }
            }
          }
        }
      }
    }
    rule {
      host = "meanz.club"
      http {
        path {
          path = "/api/register"
          path_type = "Exact"
          backend {
            service {
              name = "backend"
              port {
                number = 80
              }
            }
          }
        }
      }
    }
    rule {
      host = "meanz.club"
      http {
        path {
          path = "/"
          path_type = "Prefix"
          backend {
            service {
              name = "frontend"
              port {
                number = 80
              }
            }
          }
        }
      }
    }
    
  }
  depends_on = [ helm_release.ngnix ]
}