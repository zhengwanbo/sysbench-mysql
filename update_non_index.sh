#!/bin/bash

set -x

. ./conf.sh

# run
sysbench --db-driver=${driver} --mysql-host=${host} --mysql-port=${port} \
  --mysql-user=${user} --mysql-password=${password} --mysql-db=${dbname} \
  --tables=${tcount} --table-size=${tsize} \
  --threads=${threads} --max-requests=${requests} \
  --report-interval=${interval} --rand-type=uniform  \
  --time=${maxtime} --percentile=95 \
  oltp_update_non_index run
