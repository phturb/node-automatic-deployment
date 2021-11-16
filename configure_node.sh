
ip_node=$1

echo "Copying the installation file on the VM"

scp -i ~/.ssh/id_rsa -o StrictHostKeyChecking=no install_nginx_proxy.sh nftpixelfood@$ip_node:~/install_nginx_proxy.sh

echo "Updating the file access permission"

ssh -i ~/.ssh/id_rsa -o StrictHostKeyChecking=no nftpixelfood@$ip_node "chmod +x ~/install_nginx_proxy.sh"

echo "Executing the installation file for the node"

ssh -i ~/.ssh/id_rsa -o StrictHostKeyChecking=no nftpixelfood@$ip_node "./install_nginx_proxy.sh"