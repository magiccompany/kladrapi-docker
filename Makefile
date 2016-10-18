SHELL=/bin/bash
IMAGE_NAME=webreactor/kladrapi-docker
IMAGE_TAG=v0.0.1
IMAGE_FULL_NAME=$(IMAGE_NAME):$(IMAGE_TAG)

build:
	if [ -f composer.json ]; then \
		composer install; \
	fi;
	cp ./docker/dbf2csv /usr/bin/
	chmod a+x .

build-image:
	docker run --rm -v $(shell pwd):/var/www webreactor/nginx-php:v0.0.1 make build
	docker build -t $(IMAGE_FULL_NAME) .
