variable "project_id" {
    type = string
    default = "cronos-node"
}

variable "region" {
    type = string
    default = "northamerica-northeast1"
}

variable "zone" {
    type = string
    default = "northamerica-northeast1-a"
}

variable "username" {
    type = string
    default = "nftpixelfood"
}

variable "nginx_machine_type" {
    type = string
    default = "e2-micro"
}

variable "node_machine_type" {
    type = string
    default = "e2-micro"
}

variable "domain_name" {
  type = string
  default = "bonjack.club"
}

variable "dns_zone_name" {
  type = string
  default = "bonjack"
}