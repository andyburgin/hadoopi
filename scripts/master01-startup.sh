#!/bin/bash

echo "Start dfs"
su hduser - -c "/opt/hadoop/sbin/start-dfs.sh"

echo "Start yarn"
su hduser - -c "/opt/hadoop/sbin/start-yarn.sh"

##echo "Start hbase"
##su hduser - -c "/opt/hbase/bin/start-hbase.sh"

##echo "Start hbase thrift server"
##su hduser - -c "nohup /opt/hbase/bin/hbase thrift start > /opt/hadoop/logs/hbase-thrift.out 2> /opt/hadoop/logs/hbase-thrift.err &"

#echo "Start zookeeper"
#su hduser - -c "/opt/zookeeper/bin/zkServer.sh start"

echo "Start hiveserver2"
su hduser - -c "cd /opt/hive && nohup /opt/hive/bin/hive --service hiveserver2 > /opt/hadoop/logs/hive.out 2> /opt/hadoop/logs/hive.err &"

echo "Start job history server"
su hduser - -c "/opt/hadoop/sbin/mr-jobhistory-daemon.sh start historyserver"

echo "Start hue"
su hue - -c "/opt/hue/build/env/bin/supervisor -d"

echo "Start oozie"
su oozie - -c "cd /opt/oozie && bin/oozied.sh start"

echo "Start Sqoop"
su hduser - -c "cd /opt/sqoop/ && /opt/sqoop/bin/sqoop.sh server start"

echo "Start Process Exporter"
/opt/process-exporter/process-exporter -config.path /opt/process-exporter/conf/config.yml > /opt/process-exporter/logs/process-exporter.out 2> /opt/process-exporter/logs/process-exporter.err &

echo "Start mysqld exporter"
export DATA_SOURCE_NAME='exporter:ersdfsdfsd@(localhost:3306)/' && /opt/mysqld_exporter/mysqld_exporter > /opt/mysqld_exporter/log/mysqld_exporter.out 2> /opt/mysqld_exporter/log/mysqld_exporter.err &

