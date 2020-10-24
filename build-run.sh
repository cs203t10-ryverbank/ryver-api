# Create a fresh build and package for all microservices.
mvn clean package -Dmaven.test.skip=true
# Compose all docker images and run in the background.
docker-compose up -d
# To stop the services, run:
# docker-compose down

