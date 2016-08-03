# create hdfs file system
directory "/hdfs" do
        mode  "0777"
end

directory "/hdfs/tmp" do
        owner "hduser"
        group "hadoop"
        mode  "0750"
        recursive true
end

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
	returns [0,1]
end

execute "create hduser home" do
        command "/opt/hadoop/bin/hadoop fs -mkdir /user/hduser"
        user "hduser"
	returns [0,1]
end

execute "start hdfs for config" do
        command "/opt/hadoop/bin/hadoop fs -chown hduser:hduser /user/hduser"
        user "hduser"
end

execute "stop hdfs for config" do
        command "/opt/hadoop/sbin/stop-dfs.sh"
        user "hduser"
end

