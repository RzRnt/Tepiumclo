resource "google_container_cluster" "automation-cluster" {
  name                      = "automation-cluster"
  zone                      = "asia-southeast1-b"
  initial_node_count        = 3
  remove_default_node_pool  = true
}

resource "google_container_node_pool" "automation-cluster-nodes" {
  name       = "automation-node"
  location   = "asia-southeast1"
  cluster    = "${google_container_cluster.automation-cluster.name}"
  node_count = 8
  node_config {
    preemptible  = true
    machine_type = "n1-standard-4"
  }
}

output "client_certificate" {
  value     = "${google_container_cluster.automation-cluster.master_auth.0.client_certificate}"
  sensitive = true
}

output "client_key" {
  value     = "${google_container_cluster.automation-cluster.master_auth.0.client_key}"
  sensitive = true
}

output "cluster_ca_certificate" {
  value     = "${google_container_cluster.automation-cluster.master_auth.0.cluster_ca_certificate}"
  sensitive = true
}

output "host" {
  value     = "${google_container_cluster.automation-cluster.endpoint}"
  sensitive = true
}