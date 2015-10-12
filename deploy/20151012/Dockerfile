FROM golang:1.5

MAINTAINER WHITEPLUS System "sysadmin@wh-plus.com"

RUN /bin/cp -f /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
 && apt-get update 1> /dev/null \
 && apt-get upgrade -y -q --no-install-recommends \
 && apt-get install -y --no-install-recommends \
 git \
 curl \
 python-pip \
 php5-fpm php5-mysql php-apc php5-curl php5-gd php5-intl php5-mcrypt php5-memcache \
 php5-sqlite php5-tidy php5-xmlrpc php5-xsl php5-pgsql php5-mongo libapache2-mod-php5 \
 php5-xdebug \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && pip install \
 awscli \
 awsebcli \
 && go get github.com/robfig/glock \
 && go get github.com/WHITEPLUS/gracefresh
