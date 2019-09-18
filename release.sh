#!/bin/bash

VER=$1

if [[ -z "$VER" ]]; then
  echo "Enter semver version."
  exit 1
fi

./avro-to-php app:build avro-to-php
git commit -am "$VER"
git tag "$VER"
git push --follow-tags

docker build -t chasdevs/avro-to-php --no-cache .
docker tag chasdevs/avro-to-php chasdevs/avro-to-php:"$VER"
docker push chasdevs/avro-to-php:latest
docker push chasdevs/avro-to-php:"$VER"