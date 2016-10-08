#!/bin/bash

echo "Start hbase"
su hduser - -c "/opt/hbase/bin/start-hbase.sh"

echo "Start hbase thrift server"
su hduser - -c "nohup /opt/hbase/bin/hbase thrift start > /opt/hbase/logs/hbase-thrift.out 2> /opt/hbase/logs/hbase-thrift.err &"

echo "Start Livy"
su hduser - -c "CLASSPATH=`hadoop classpath` /bin/livy-server"

