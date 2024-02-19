resource "kubernetes_deployment" "mongo" {
  metadata {
    name = "mongo"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "mongo"
      }
    }

    template {
      metadata {
        labels = {
          app = "mongo"
        }
      }

      spec {
        container {
          image = "mongo"
          name  = "mongo"
    
    # Lets avoid complications for now
        #   resources {
        #     limits = {
        #       cpu    = "0.5"
        #       memory = "512Mi"
        #     }
        #     requests = {
        #       cpu    = "250m"
        #       memory = "50Mi"
        #     }
        #   }

        #   liveness_probe {
        #     http_get {
        #       path = "/"
        #       port = 80

        #       http_header {
        #         name  = "X-Custom-Header"
        #         value = "Awesome"
        #       }
        #     }

          }
        }
      }
    }
}

resource "kubernetes_service" "mongo" {
  metadata {
    name = "mongo"
  }
  spec {
    selector = {
      app = "mongo"
    }
    port {
      port        = 27017
      target_port = 27017
    }

    type = "ClusterIP"
  }
}
