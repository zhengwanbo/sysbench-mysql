#!/bin/bash

RUNDIR=`pwd`
basepath=$(dirname $(pwd))

rm -f ./report/*.log

for i in 32 64 128 256 512 1024 2048
do
    echo "cat $RUNDIR/logs/${i}_select.sh.log >> $RUNDIR/report/${i}_select.log"
    sh $RUNDIR/cexec.sh "cat $RUNDIR/logs/${i}_select.sh.log" >> $RUNDIR/report/${i}_select.log
    sh $RUNDIR/cexec.sh "cat $RUNDIR/logs/${i}_oltp.sh.log" >> $RUNDIR/report/${i}_oltp.log
    sh $RUNDIR/cexec.sh "cat $RUNDIR/logs/${i}_insert.sh.log" >> $RUNDIR/report/${i}_insert.log
    sh $RUNDIR/cexec.sh "cat $RUNDIR/logs/${i}_update_index.sh.log" >> $RUNDIR/report/${i}_update_index.log
    sh $RUNDIR/cexec.sh "cat $RUNDIR/logs/${i}_update_non_index.sh.log" >> $RUNDIR/report/${i}_update_non_index.log
    sh $RUNDIR/cexec.sh "cat $RUNDIR/logs/${i}_delete.sh.log" >> $RUNDIR/report/${i}_delete.log
done

sleep 3
rm -f select.log oltp.log insert.log update_index.log update_non_index.log delete.log

for i in 32 64 128 256 512 1024 2048
do
   sh logparse.sh report/${i}_select.log >> ./select.log
   sh logparse.sh report/${i}_oltp.log >> ./oltp.log
   sh logparse.sh report/${i}_insert.log >> ./insert.log
   sh logparse.sh report/${i}_update_index.log >> ./update_index.log
   sh logparse.sh report/${i}_update_non_index.log >> ./update_non_index.log
   sh logparse.sh report/${i}_delete.log >> ./delete.log
done

cat ./select.log | awk -F ':' '{print $2}'
echo ""
cat ./oltp.log | awk -F ':' '{print $2}'
echo ""
cat ./insert.log | awk -F ':' '{print $2}'
echo ""
cat ./update_index.log | awk -F ':' '{print $2}'
echo ""
cat ./update_non_index.log | awk -F ':' '{print $2}'
echo ""
cat ./delete.log | awk -F ':' '{print $2}'
