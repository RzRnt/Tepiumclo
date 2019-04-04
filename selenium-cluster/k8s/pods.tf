resource "kubernetes_replication_controller" "selenium-hub" {
  metadata {
    name = "selenium-hub"

    labels {
      app  = "selenium"
    }
  }

  spec {
    replicas = 1
    selector = {
      app  = "selenium"
    }

    template {
      container {
        image = "selenium/hub:3.141"
        name  = "master"

        port {
          container_port = 4444
        }

        resources {
          limits{
              cpu    = "0.5"
              memory = "1000Mi"
          }
          requests {
            cpu    = "250m"
            memory = "1000Mi"
          }
        }
      }
    }
  }
}

resource "kubernetes_replication_controller" "selenium-node-chrome" {
  metadata {
    name = "redis-slave"

    labels {
      app  = "redis"
      role = "slave"
      tier = "backend"
    }
  }

  spec {
    replicas = 2

    selector = {
      app  = "redis"
      role = "slave"
      tier = "backend"
    }

    template {
      container {
        image = "gcr.io/google_samples/gb-redisslave:v1"
        name  = "slave"

        port {
          container_port = 6379
        }

        env {
          name  = "GET_HOSTS_FROM"
          value = "dns"
        }

        resources {
          requests {
            cpu    = "100m"
            memory = "100Mi"
          }
        }
      }
    }
  }
}