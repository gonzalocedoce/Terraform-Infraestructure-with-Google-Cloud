# VPC Network
resource "google_compute_network" "mynetwork" {
  name                    = "mynetwork"
  auto_create_subnetworks = true
}

# Firewall rule — allow HTTP, SSH, RDP, and ICMP
resource "google_compute_firewall" "mynetwork-allow-http-ssh-rdp-icmp" {
  name    = "mynetwork-allow-http-ssh-rdp-icmp"
  network = google_compute_network.mynetwork.self_link

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "3389"]
  }

  allow {
    protocol = "icmp"
  }

  source_ranges = ["0.0.0.0/0"]
}

# VM instance — asia-south1-c
module "mynet-vm-1" {
  source           = "./modules/instance"
  instance_name    = "mynet-vm-1"
  instance_zone    = "asia-south1-c"
  instance_network = google_compute_network.mynetwork.self_link
}

# VM instance — europe-west4-b
module "mynet-vm-2" {
  source           = "./modules/instance"
  instance_name    = "mynet-vm-2"
  instance_zone    = "europe-west4-b"
  instance_network = google_compute_network.mynetwork.self_link
}
