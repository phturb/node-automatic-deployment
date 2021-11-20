
bucket=$1
domain=$2

sed "s/{{NODE_ADDRESS}}/$domain/" ./test_app/public/index.template.html > ./test_app/public/index.html
gsutil cp ./test_app/public/index.html gs://$bucket/index.html
gsutil iam ch allUsers:objectViewer gs://$bucket