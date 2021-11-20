# /usr/bin/bash

ip_node=$1
ip_nginx=$2
domain=$3
domain_prefix=$4

cd nginx

echo "Creating $domain_prefix.$domain file with the right nginx configuration"

sed "s/{{NODE_DOMAIN_ADDRESS}}/$domain_prefix.$domain/" server_template.conf > $domain_prefix.$domain
sed -i "s/{{IP_NODE}}/$ip_node/" $domain_prefix.$domain
sed -i "s/{{DOMAIN_ADDRESS}}/$domain/" $domain_prefix.$domain

echo "Copying project.$domain to the nginx server"

scp -i ~/.ssh/id_rsa -o StrictHostKeyChecking=no $domain_prefix.$domain nftpixelfood@$ip_nginx:~/$domain_prefix.$domain
scp -i ~/.ssh/id_rsa -o StrictHostKeyChecking=no install_nginx.sh nftpixelfood@$ip_nginx:~/install_nginx.sh

echo "Execute remote installation script"

ssh -i ~/.ssh/id_rsa -o StrictHostKeyChecking=no nftpixelfood@$ip_nginx "sudo ~/install_nginx.sh $domain_prefix.$domain"

cd ..