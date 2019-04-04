resource "kubernetes_service" "selenium-hub" {
  metadata {
    name = "selenium-hub"

    labels {
      app  = "selenium"
    }
  }

  spec {
    selector {
      app  = "selenium"
    }

    port {
      port        = 4444
      target_port = 4444
    }
  }
}


apiVersion: v1
kind: Service
metadata:
  name: selenium-hub
  labels:
    app: selenium-hub
spec:
  ports:
  - port: 4444
    targetPort: 4444
    name: port0
  selector:
    app: selenium-hub
  type: NodePort
  sessionAffinity: None