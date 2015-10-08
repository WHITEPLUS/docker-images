FROM golang:1.5

MAINTAINER WHITEPLUS System "sysadmin@wh-plus.com"

RUN /bin/cp -f /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
 && apt-get update 1> /dev/null \
 && apt-get upgrade -y -q --no-install-recommends \
 && apt-get install -y --no-install-recommends \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && go get github.com/robfig/glock \
 && go get github.com/WHITEPLUS/gracefresh
