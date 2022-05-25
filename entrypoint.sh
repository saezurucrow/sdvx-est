#!/bin/bash
set -e

rm -f /sdvxest/tmp/pids/server.pid

exec "$@"