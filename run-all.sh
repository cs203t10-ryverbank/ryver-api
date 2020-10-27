#!/bin/bash

# This file is for the Docker image only.
java -jar ./ryver-registry/out.jar &
java -jar ./ryver-gateway/out.jar &
java -jar ./ryver-auth/out.jar &
java -jar ./ryver-cms/out.jar &
java -jar ./ryver-fts/out.jar &
java -jar ./ryver-market/out.jar
