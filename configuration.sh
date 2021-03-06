cd terraform

echo "Apply terraform"

terraform apply -auto-approve

echo "Waiting for the vms to warm up"

sleep 4m

echo "Fetching the information from terraform"

ip_node=$(terraform output --raw ip_node)
priv_ip_node=$(terraform output --raw priv_ip_node)
ip_nginx=$(terraform output --raw ip_nginx)
domain=$(terraform output --raw domain)
bucket_name=$(terraform output --raw bucket_name)
domain_prefix=$(terraform output --raw prefix_domain)

cd ..

echo "Configure nginx reverse proxy"

./configure_nginx_proxy.sh $priv_ip_node $ip_nginx $domain $domain_prefix

echo "Configure the cronos node"

./configure_node.sh $ip_node

echo "Configure static website"

./configure_static_website.sh $bucket_name $domain_prefix.$domain

echo "Access node on : $domain_prefix.$domain"
echo "Accss test app on : $bucket_name"