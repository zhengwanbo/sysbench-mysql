#!/bin/bash

#初始化文件夹
#cd `dirname $0`

g_PWD=${PWD}

g_SH_PWD=${g_PWD%/*}

logFile=$1

tps=$(cat $logFile | grep 'transactions:' | awk '{match($0,/\([^()]*\)/);print substr($0,RSTART+1,RLENGTH-2)}' | awk '{print $1}' | awk '{sum += $1};END {print sum}' )

qps=$(cat $logFile | grep 'queries:' | awk '{match($0,/\([^()]*\)/);print substr($0,RSTART+1,RLENGTH-2)}' | awk '{print $1}' | awk '{sum += $1};END {print sum}' )

lyavg=$(cat $logFile |grep avg: | awk '{print $NF}' | awk '{sum+=$1} END {print sum/NR}')

ly99=$(cat $logFile |grep 'percentile:' | awk -F ':' '{print $NF}' | awk '{sum+=$1} END {print sum/NR}')

lymax=$(cat $logFile |grep max: | awk '{print $NF}' | awk 'BEGIN {max = 0} {if ($1+0 > max+0) max=$1} END {print max}')

printf "$logFile: $tps\t$qps\t$lyavg\t$ly99\t$lymax\n"
