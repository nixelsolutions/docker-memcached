#!/bin/bash

set -e

[ "$DEBUG" == "1" ] && set -x && set +e

if [ "${MEMCACHED_PEER}" == "**ChangeMe**" -o -z "${MEMCACHED_PEER}" ]; then
   echo "*** ERROR: you need to define MEMCACHED_PEER environment variable - Exiting ..."
   exit 1
fi

echo "=> Starting Memcached with these parameters:"
echo "MEMCACHED_PEER = ${MEMCACHED_PEERO}"

/usr/bin/supervisord
