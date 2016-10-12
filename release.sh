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

# ビルドイメージがない場合はビルドする
IMAGE_EXISTS=`docker images -a $REPOSITORY:$TAG | tail -n +2 | sed -e "s/[\r\n]\+//g"`
if [[ -z $IMAGE_EXISTS ]] ; then
  cd $(dirname $0)
  ./build.sh $@ || fail 'Dockerイメージのビルドに失敗しました'
fi

cd $@

`aws ecr get-login --region us-east-1` \
|| fail 'ログインに失敗しました'

docker push $URL/$REPOSITORY:$TAG \
|| fail 'イメージのPUSHに失敗しました'
