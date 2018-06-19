# running sysbench

    1、modify the conf.sh to confirm the database's connection information is right;
    2、use prepare to create database and load the data into table  one by one; or use parallel-prepare.sh to create database and load the data into table parallel;
    3、start running the sysbench after load data finished. for example: ./select.sh or ./oltp.sh
    4、get the result after finished.


# running sysbench automatically
# user can make the plan to run sysbench automatically.

    1、modify the /etc/hosts, add the name for each host ip. example, 172.16.20.1 t001 172.16.20.2 t002
    2、git clone the sysbnech-mysql 
    3、cd sysbench-mysql; confirm the conf.sh.toml, the connection of database info;
    4、copy all the sysbench file to different host, same path, chmod +x *.sh;
    5、cd runtest, then modiry the runParaller_test.sh, config the run test hostname; 
    6、start run sysbench : ./runParaller_test.sh
    7、after finished the test, modify the cexec.sh to config the host, to get the all reports : ./getreport.sh
