FROM webreactor/nginx-php:v0.0.1

RUN apt-get update \
    && curl -s https://packagecloud.io/install/repositories/phalcon/stable/script.deb.sh | bash \
    && apt-get install -y p7zip-full python-setuptools php5-mongo php5-phalcon \
    && easy_install dbfread

COPY . /var/www
COPY .docker/dbf2csv /usr/bin/
