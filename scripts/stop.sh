#!/bin/bash

killall -q redis-server

rm -f "${PWD}/data/redis/redis-server.pid"

rm -f "${PWD}/data/redis/redis-server.sock"

> "${PWD}/data/redis/redis-server.log"

killall -q mongod

rm -f "${PWD}/data/mongod/mongod.pid"

> "${PWD}/data/mongod/mongod.log"
