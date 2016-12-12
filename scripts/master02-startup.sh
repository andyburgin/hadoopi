#!/bin/bash

echo "Start hbase"
su hduser - -c "/opt/hbase/bin/start-hbase.sh"

echo "Start hbase thrift server"
su hduser - -c "nohup /opt/hbase/bin/hbase thrift start > /opt/hbase/logs/hbase-thrift.out 2> /opt/hbase/logs/hbase-thrift.err &"

echo "Start Livy"
su hduser - -c "export CLASSPATH=`hadoop classpath`; export SPARK_CONF_DIR=/opt/spark/conf; export SPARK_HOME=/opt/spark; export HUE_SECRET_KEY=hduser; /opt/livy/bin/livy-server start"

echo "Start Solr"
su hduser - -c "/opt/solr/bin/solr start -m 256m -c -z master02:2181/solr -a '-Dsolr.hdfs.home=hdfs://master01:54310/solr'"

