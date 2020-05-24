#!/usr/bin/env bash

rm -rf docker
docker-compose up -d
echo -n 'wait for app to be ready '
until $(curl --output /dev/null --silent --head --fail localhost:8888); do
  printf '.'
  sleep 5
done
sleep 10
npm run test:end2end
