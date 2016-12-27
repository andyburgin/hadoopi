# create solr hdfs folder
execute "start hdfs for solr" do
        command "/opt/hadoop/sbin/start-dfs.sh"
        user "hduser"
        returns [0,1]
end

execute "create solr folder" do
        command "/opt/hadoop/bin/hadoop fs -mkdir /solr"
        user "hduser"
        returns [0,1]
end

execute "chmod solr folder" do
        command "/opt/hadoop/bin/hadoop fs -chmod 777 /solr"
        user "hduser"
        returns [0,1]
end

execute "chmod tmp folder" do
        command "/opt/hadoop/bin/hadoop fs -chmod 777 /tmp"
        user "hduser"
        returns [0,1]
end

execute "stop hdfs" do
        command "/opt/hadoop/sbin/stop-dfs.sh"
        user "hduser"
end

