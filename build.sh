#! /usr/bin/env bash

URL=197815974035.dkr.ecr.us-east-1.amazonaws.com

fail() {
  echo $@ 1>&2
  exit 1
}

([ $# -eq 1 ] && \
 [ -d $@ ] \
) || fail 'Dockerのビルドパスを引数にしてください'

([ -f $@/Dockerfile ] \
) || fail 'Dockerfileが見つかりません'

REPOSITORY=`dirname $@`
TAG=`basename $@`

cd $@

docker build -t $REPOSITORY:$TAG .

docker tag $REPOSITORY:$TAG $URL/$REPOSITORY:$TAG \
|| fail 'Dockerイメージのタグを付与できませんでした'
