# Update all submodules to latest of the branch
git submodule foreach 'git pull'
# Create a fresh build and package for all microservices.
mvn clean package -Dmaven.test.skip=true
# Compose the docker image.
docker build -t bryanmylee/ryver-api .
# Push the image
docker push bryanmylee/ryver-api
# Redeploy the image on the server
ssh -i ryver-api-keypair.pem ec2-user@54.255.146.38 '$HOME/redeploy-container.sh; exit'
# To run the image, use
# docker run -p 8761:8761 -p 80:8080 --name ryver-api bryanmylee/ryver-api
