terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {
  credentials = file("my_gcp.json")

  project = "pacific-element-321011"
  region  = "europe-west3"
  zone    = "europe-west3-c"
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}

resource "google_compute_instance" "vm_instance" {
  name         = "test-terraform-instance"
  machine_type = "e2-small"

  boot_disk {
    initialize_params {
      image = "debian-10-buster-v20210721"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
    }
  }
  metadata = {
    ssh-keys = "username:${file("id_rsa.pub")}"
  }
}
