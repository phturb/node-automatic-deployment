provider "google" {
 credentials = file("service_account.json")
 project     = var.project_id
 region      = var.region
}

data "google_dns_managed_zone" "domain_dns_zone" {
  name     = var.dns_zone_name
}

resource "google_dns_record_set" "nginx_record" {
  name         = "project.${data.google_dns_managed_zone.domain_dns_zone.dns_name}"
  type         = "A"
  ttl          = 300
  managed_zone = data.google_dns_managed_zone.domain_dns_zone.name
  rrdatas      = [google_compute_address.nginx_address.address]
}

resource "google_compute_address" "nginx_address" {
  name     = "nginx-ip"
  region   = var.region
}

resource "google_compute_instance" "cronos_node_vm" {
    name = "cronos-node-vm-project"
    machine_type = var.node_machine_type
    zone = var.zone

    boot_disk {
        initialize_params {
            image = "debian-cloud/debian-9"
        }
    }

    metadata_startup_script = "sudo apt-get update; sudo apt-get install -yq git nginx"

    network_interface {
        network = "default"

        access_config {
            // Include this section to give the VM an external ip address
        }
    }

    metadata = {
        ssh-keys = "${var.username}:${file("~/.ssh/id_rsa.pub")}"
    }
}

resource "google_compute_instance" "nginx_vm" {
    name = "nginx-vm-project"
    machine_type = var.nginx_machine_type
    zone = var.zone

    boot_disk {
        initialize_params {
            image = "debian-cloud/debian-9"
        }
    }

    tags = ["nginx", "nginx-firewall"]

    metadata_startup_script = "sudo apt-get update; sudo apt-get install -yq git nginx"

    network_interface {
        network = "default"

        access_config {
            nat_ip = google_compute_address.nginx_address.address
            // Include this section to give the VM an external ip address
        }
    }

    metadata = {
        ssh-keys = "${var.username}:${file("~/.ssh/id_rsa.pub")}"
    }
}

resource "google_compute_firewall" "nginx_firewall" {
    name    = "nginx-firewall"
    network = "default"

    allow {
        protocol = "tcp"
        ports    = ["80", "443", "22", "8080", "26657", "8545"]
    }

    source_ranges = ["0.0.0.0/0"]
    target_tags = ["nginx-firewall"]
}

resource "google_storage_bucket" "test_app_static_site" {
    name = var.domain_name
    location = "us"
    force_destroy = true
    uniform_bucket_level_access = false

    website {
        main_page_suffix = "index.html"
    }
    cors {
        origin          = ["*"]
        method          = ["GET", "HEAD", "PUT", "POST", "DELETE"]
        response_header = ["*"]
        max_age_seconds = 3600
    }

}
resource "google_storage_bucket_access_control" "public_rule" {
  bucket = google_storage_bucket.test_app_static_site.name
  role   = "READER"
  entity = "allUsers"
}

