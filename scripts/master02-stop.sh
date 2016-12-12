#!/bin/bash

echo "Stop hbase"
su hduser - -c "/opt/hbase/bin/stop-hbase.sh"

echo "Stop hbase thrift server"
su hduser - -c "kill $(ps -ef | grep ThriftServer | awk '{print $2}')"

echo "Stop Livy"
su hduser - -c "kill $(ps -ef | grep livy | awk '{print $2}')"

echo "Stop Solr"
su hduser - -c "/opt/solr/bin/solr stop -all"
