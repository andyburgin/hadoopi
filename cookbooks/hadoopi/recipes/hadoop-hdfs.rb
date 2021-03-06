
# format name node, allow return code of 1 incase already formatted
execute "format namenode" do
        command "/opt/hadoop/bin/hadoop namenode -format -nonInteractive"
        user "hduser"
        returns [0,1]
end

# create default user in hdfs
execute "start hdfs for config" do
	command "/opt/hadoop/sbin/start-dfs.sh"
	user "hduser"
end

execute "create user home" do
        command "/opt/hadoop/bin/hadoop fs -mkdir /user"
        user "hduser"
        retry_delay 5
        retries 5
end

execute "create hduser home" do
        command "/opt/hadoop/bin/hadoop fs -mkdir -p /user/hduser"
        user "hduser"
end

execute "Chown hduser home" do
        command "/opt/hadoop/bin/hadoop fs -chown hduser:hduser /user/hduser"
        user "hduser"
end

execute "create Hive Warehouse folder" do
        command "/opt/hadoop/bin/hadoop fs -mkdir -p /user/hive/warehouse"
        user "hduser"
end

execute "Make Hive warehouse folder accessible to all" do
        command "/opt/hadoop/bin/hadoop fs -chmod a+w /user/hive/warehouse"
        user "hduser"
end

execute "stop hdfs for config" do
        command "/opt/hadoop/sbin/stop-dfs.sh"
        user "hduser"
end

