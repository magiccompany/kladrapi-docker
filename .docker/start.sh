#!/bin/bash

cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

wait-for-service $MONGO_HOST 27017
wait-for-service localhost 80

start-nginx-php-nxlog