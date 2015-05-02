#!/bin/bash

killall -q redis-server

rm -f "${PWD}/data/redis/redis-server.pid"

rm -f "${PWD}/data/redis/redis-server.sock"

> "${PWD}/data/redis/redis-server.log"
