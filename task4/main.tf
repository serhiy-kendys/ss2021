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
  project = var.project
  region = var.region
  zone = "${var.region}-c"
}

resource "google_compute_instance" "vm_instance" {
  name = "test-terraform-instance"
  machine_type = "e2-small"
  tags = ["http-server","https-server"]

  boot_disk {
    initialize_params {
      image = "debian-10-buster-v20210721"
    }
  }

  network_interface {
    network = "default"
    access_config {
      nat_ip = google_compute_address.static.address
    }
  }
  metadata = {
    ssh-keys = "${var.user}:${file(var.publickeypath)}"
  }

  provisioner "file" {
   source = "startup.sh"
   destination = "/tmp/startup.sh"
   connection {
     host        = google_compute_address.static.address
     type        = "ssh"
     user        = var.user
     timeout     = "600s"
     private_key = file(var.privatekeypath)
   }
  }

  provisioner "remote-exec" {
    connection {
      host = google_compute_address.static.address
      type = "ssh"
      user = var.user
      timeout = "600s"
      private_key = file(var.privatekeypath)
    }
    inline = [
     "chmod a+x /tmp/startup.sh",
     "sudo /tmp/startup.sh"
    ]
  }
}

resource "google_compute_address" "static" {
  name = "vm-public-address"
  project = var.project
  region = var.region
}
