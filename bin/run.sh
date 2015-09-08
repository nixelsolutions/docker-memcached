#!/bin/bash

set -e

[ "$DEBUG" == "1" ] && set -x && set +e

if [ "${MEMCACHED_PEERS}" == "**ChangeMe**" -o -z "${MEMCACHED_PEERS}" ]; then
   echo "*** ERROR: you need to define MEMCACHED_PEER environment variable - Exiting ..."
   exit 1
fi

if [ "${MY_IP}" == "**ChangeMe**" -o -z "${MY_IP}" ]; then
   echo "*** ERROR: you need to define MY_IP environment variable - Exiting ..."
   exit 1
fi

export MEMCACHED_PEER=`echo ${MEMCACHED_PEERS} | tr ',' '\n' | grep -v ${MY_IP}`

echo "=> Starting Memcached with these parameters:"
echo "MEMCACHED_PEER = ${MEMCACHED_PEER}"

/usr/bin/supervisord
