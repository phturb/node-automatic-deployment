# CLOUD PROJECT

## Prerequisit

You need to add the `service_account.json` file in the terraform folder to have access to the google cloud environment.

You need installed on your machine :

- google cloud cli (gcloud)
- terraform

You also need to have an account with credits for the google cloud platform

You need to buy a domain and create a cloud dns zone in the google cloud platform.

You need to verify that you are the owner of the domain on the google website management console.

You need to add your service account as an owner of the domain on the google website management console.

## How to run

After all these prerequisit are validated, you can run the `configuration.sh` script and your environment will be good to go. You might need to change your own `terraform.tvars` file to be able to launch on your environment.

## Configuration

```
project_id = "cronos-node"
region = "northamerica-northeast1"
zone = "northamerica-northeast1-a"
username = "nftpixelfood"
nginx_machine_type = "e2-micro"
node_machine_type = "e2-micro"
domain_name = "bonjack.club"
dns_zone_name = "bonjack"
prefix_domain = "project"
prefix_domain_static = "project-static"
```