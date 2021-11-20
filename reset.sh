echo "Remove infrastructure"

cd terraform

domain=$(terraform output --raw domain)
domain_prefix=$(terraform output --raw prefix_domain)

terraform destroy

cd ..

echo "Clear config files"

cd nginx

rm $domain_prefix.$domain

cd ..

cd test_app/public

rm index.html

cd ../..