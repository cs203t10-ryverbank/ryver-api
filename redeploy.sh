# Update all submodules to latest of the branch
git submodule foreach 'git pull'
# Build and package for all microservices.
mvn package -Dmaven.test.skip=true
# Compose the docker image.
docker build -t bryanmylee/ryver-api .
# Push the image.
# Make sure to log into the Docker cli first.
docker push bryanmylee/ryver-api
# Redeploy the image on the server.
# Make sure to set the remote user and host env variables.
ssh -i ryver-api-keypair.pem $REMOTE_USER@$REMOTE_HOST '$HOME/redeploy-container.sh; exit'
# To run the image locally, use:
# docker run -p 8761:8761 -p 80:8080 --name ryver-api bryanmylee/ryver-api
