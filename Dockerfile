FROM webreactor/nginx-php:v0.0.1

RUN apt-get update \
    && curl -s https://packagecloud.io/install/repositories/phalcon/stable/script.deb.sh | bash \
    && apt-get install -y php5-mongo php5-phalcon \
    && curl -s -L https://sourceforge.net/projects/dbfpy/files/latest/download > dbfpy.tar.gz \
	&& tar -xzf dbfpy.tar.gz \
	&& rm dbfpy.tar.gz \
	&& cd $(ls|grep dbfpy) \
	&& python setup.py install \
	&& cd .. \
	&& rm -rf $(ls|grep dbfpy)

COPY . /var/www
