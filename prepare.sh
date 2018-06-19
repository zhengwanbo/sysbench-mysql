#!/bin/bash

set -x

. ./conf.sh

if [[ ${password} = "" ]];
then
    mysql -h ${host} -P ${port} -u${user} -e "CREATE DATABASE IF NOT EXISTS ${dbname}"
else
    mysql -h ${host} -P ${port} -u${user} -p${password} -e "CREATE DATABASE IF NOT EXISTS ${dbname}"
fi

echo "begin at `date` ..."
time_begin=$(echo "$(date +%s)*1000 + $(date +%N)/1000000" | bc)

sysbench --db-driver=${driver} --mysql-host=${host} --mysql-port=${port} \
 --mysql-user=${user} --mysql-password=${password} --mysql-db=${dbname} \
 --tables=${tcount} --table-size=${tsize} --threads=${threads} \
 oltp_read_write  prepare

time_end=$(echo "$(date +%s)*1000 + $(date +%N)/1000000" | bc)
time_total=$(echo "scale=3;  (${time_end}-${time_begin})/1000" | bc)

echo "end at `date`"
echo "prepare data total time=${time_total} s"
