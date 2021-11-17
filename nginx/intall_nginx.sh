echo "Move projet.$domain to the right place"

sudo cp ~/$1 /etc/nginx/sites-available/$1

sudo unlink /etc/nginx/sites-enabled/default
sudo rm /etc/nginx/sites-available/default
sudo ln -s /etc/nginx/sites-available/$1 /etc/nginx/sites-enabled/$1

echo "Reconfigure nginx"

sudo sed -i "s/# server_names_hash_bucket_size 64;/server_names_hash_bucket_size 64;/" /etc/nginx/nginx.conf

echo "Restart nginx"

sudo systemctl restart nginx