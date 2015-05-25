#!/bin/bash

[ -d "${PWD}/data/redis" ] || mkdir -p "${PWD}/data/redis"

[ -d "${PWD}/data/mongod" ] || mkdir -p "${PWD}/data/mongod"

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

sh "#{DIR}/scripts/stop.sh"

redis-server "${PWD}/data/redis/redis.conf"

mongod --config "${PWD}/data/mongod/mongod.conf"
