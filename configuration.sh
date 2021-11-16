cd terraform

# echo "Apply terraform"

# terraform apply

echo "Fetching the information from terraform"

ip_node=$(terraform output --raw ip_node)
priv_ip_node=$(terraform output --raw priv_ip_node)
ip_nginx=$(terraform output --raw ip_nginx)
domain=$(terraform output --raw domain)
bucket_name=$(terraform output --raw bucket_name)

cd ..

echo "Configure nginx reverse proxy"

./coonfigure_nginx_proxy.sh $priv_ip_node $ip_nginx $domain

echo "Configure the cronos node"

./configure_node.sh $ip_node

echo "Configure static website"

./configure_static_website.sh $bucket_name