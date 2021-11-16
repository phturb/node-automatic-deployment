# /usr/bin/bash

ip_node=$1
ip_nginx=$2
domain=$3

cd nginx

echo "Creating projet.$domain file with the right nginx configuration"

sed "s/{{NODE_DOMAIN_ADDRESS}}/projet.$domain/" server_template.conf > projet.$domain
sed -i "s/{{IP_NODE}}/$ip_node/" projet.$domain

echo "Copying projet.$domain to the nginx server"

scp -i ~/.ssh/id_rsa -o StrictHostKeyChecking=no projet.$domain nftpixelfood@$ip_nginx:~/projet.$domain

echo "Move projet.$domain to the right place"

ssh -i ~/.ssh/id_rsa -o StrictHostKeyChecking=no nftpixelfood@$ip_nginx "sudo cp ~/projet.$domain /etc/nginx/sites-available/projet.$domain"

ssh -i ~/.ssh/id_rsa -o StrictHostKeyChecking=no nftpixelfood@$ip_nginx "sudo unlink /etc/nginx/sites-enabled/default"
ssh -i ~/.ssh/id_rsa -o StrictHostKeyChecking=no nftpixelfood@$ip_nginx "sudo ln -s /etc/nginx/sites-available/projet.$domain /etc/nginx/sites-enabled/projet.$domain"

echo "Reconfigure nginx"

ssh -i ~/.ssh/id_rsa -o StrictHostKeyChecking=no nftpixelfood@$ip_nginx 'sudo sed -i "s/# server_names_hash_bucket_size 64;/server_names_hash_bucket_size 64;/" /etc/nginx/nginx.conf'

echo "Restart nginx"

ssh -i ~/.ssh/id_rsa -o StrictHostKeyChecking=no nftpixelfood@$ip_nginx "sudo systemctl restart nginx"

cd ..