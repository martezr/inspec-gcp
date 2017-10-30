terraform {
  required_version = "~> 0.10.0"
}

provider "google" {}

resource "google_project" "example-project" {
  name = "InSpec Project"
  project_id = "inspec-project-id"
}

resource "google_compute_instance" "example-instance" {
  name         = "inspec-test"
  machine_type = "f1-micro"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-8"
    }
  }

  network_interface {
    network = "default"
  }
}
