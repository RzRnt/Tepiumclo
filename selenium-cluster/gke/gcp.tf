provider "google" {
  credetials = "${file("../../credentials.json")}"
  project = "automationproject-232616"
  region  = "asia-southeast1"
}