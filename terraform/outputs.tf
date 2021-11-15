output "ip_node" {
    description = "Node IP"
    value = google_compute_instance.cronos_node_vm.network_interface.0.access_config.0.nat_ip
}

output "priv_ip_node" {
    description = "NGINX IP"
    value = google_compute_instance.cronos_node_vm.network_interface.0.network_ip
}

output "ip_nginx" {
    description = "NGINX IP"
    value = google_compute_instance.nginx_vm.network_interface.0.access_config.0.nat_ip
}

output "url" {
  description = "Website URL"
  value       = google_storage_bucket.test_app_static_site.self_link
}

output "domain" {
    description = "Domain used"
    value = var.domain_name
}