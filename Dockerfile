# Use Java 11 as a base image
FROM openjdk:11-jre
# Set the working directory on the image
WORKDIR /app
# Copy all services to the image
COPY ./ryver-registry/target/out.jar ./ryver-registry/
COPY ./ryver-gateway/target/out.jar ./ryver-gateway/
COPY ./ryver-auth/target/out.jar ./ryver-auth/
COPY ./ryver-cms/target/out.jar ./ryver-cms/
COPY ./ryver-fts/target/out.jar ./ryver-fts/
COPY ./ryver-market/target/out.jar ./ryver-market/
COPY ./ryver-market/lib ./ryver-market/
# Copy service runner script
COPY ./run-all.sh ./
# Expose the Eureka server port
EXPOSE 8761
EXPOSE 8080
# Run all services
CMD ./run-all.sh
