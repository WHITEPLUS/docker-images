#!/usr/bin/env bash

BEANSTALKD_PORT=${BEANSTALKD_PORT}

if [ -z ${BEANSTALKD_PORT} ]; then
  BEANSTALKD_PORT=11300
fi

beanstalkd -p ${BEANSTALKD_PORT}
