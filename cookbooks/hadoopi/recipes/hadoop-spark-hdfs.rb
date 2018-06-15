# copy spark lib files to hdfs
execute "start hdfs for copying of spark libs" do
        command "/opt/hadoop/sbin/start-dfs.sh"
        user "hduser"
end

execute "create spark lib folder" do
        command "/opt/hadoop/bin/hadoop fs -mkdir -p /user/hduser/spark/"
        user "hduser"
        retry_delay 5
        retries 5
end

execute "copy libs" do
        command "/opt/hadoop/bin/hadoop fs -copyFromLocal -f /opt/spark-#{node['spark']['version']}-bin-hadoop#{node['spark']['hadoop-version']}/lib/* /user/hduser/spark/"
        user "hduser"
        retry_delay 5
        retries 5
end

execute "stop hdfs" do
        command "/opt/hadoop/sbin/stop-dfs.sh"
        user "hduser"
end
