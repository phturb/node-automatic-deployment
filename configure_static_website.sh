
gsutil cp ./test_app/public/index.html gs://$1/index.html
gsutil iam ch allUsers:objectViewer gs://$1