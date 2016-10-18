FROM webreactor/nginx-php:v0.0.1

RUN apt-get update \
    && curl -s https://packagecloud.io/install/repositories/phalcon/stable/script.deb.sh | bash \
    && apt-get install -y php5-mongo php5-phalcon python-setuptools \
    && easy_install dbfread

COPY . /var/www
