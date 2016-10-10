#!/bin/bash

echo "Stop dfs"
su hduser - -c "/opt/hadoop/sbin/stop-dfs.sh"

echo "Stop yarn"
su hduser - -c "/opt/hadoop/sbin/stop-yarn.sh"

##echo "Stop hbase"
##su hduser - -c "/opt/hbase/bin/stop-hbase.sh"

##echo "Stop hbase thrift server"
##su hduser - -c "kill $(ps -ef | grep ThriftServer | awk '{print $2}')"

#echo "Stop zookeeper"
#su hduser - -c "/opt/zookeeper/bin/zkServer.sh stop"

echo "Stop hiveserver2"
su hduser - -c "kill $(ps -ef | grep HiveServer2 | awk '{print $2}')"

echo "Stop job history server"
su hduser - -c "/opt/hadoop/sbin/mr-jobhistory-daemon.sh stop historyserver"

echo "Stop hue"
killall supervisor

echo "Stop oozie"
su oozie - -c "cd /opt/oozie && bin/oozied.sh stop"

##echo "Stop Livy"
##su hduser - -c "/opt/livy/bin/livy-server stop"

