FROM debian:jessie

MAINTAINER WHITEPLUS System "sysadmin@wh-plus.com"

ENV NGINX_VERSION 1.9.5-1~jessie

RUN /bin/cp -f /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
 && apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62 \
 && echo "deb http://nginx.org/packages/mainline/debian/ jessie nginx" >> /etc/apt/sources.list \
 && apt-get update 1> /dev/null \
 && apt-get upgrade -y -q --no-install-recommends \
 && apt-get install -y --no-install-recommends \
 ca-certificates nginx=${NGINX_VERSION} supervisor \
 php5-fpm php5-mysql php-apc php5-curl php5-gd php5-intl php5-mcrypt php5-memcache \
 php5-sqlite php5-tidy php5-xmlrpc php5-xsl php5-pgsql php5-mongo libapache2-mod-php5 \
 php5-xdebug \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*
