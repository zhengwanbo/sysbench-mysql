#!/bin/bash

set -x

. ./conf.sh

sysbench --db-driver=${driver} --mysql-host=${host} --mysql-port=${port} \
 --mysql-user=${user} --mysql-password=${password} --mysql-db=${dbname} \
 --tables=${tcount} --table-size=${tsize} \
 --num-threads=${threads} --report-interval=${interval} \
 --max-requests=${requests} --percentile=95 --time=${maxtime} \
 --rand-type=uniform \
 oltp_insert run
