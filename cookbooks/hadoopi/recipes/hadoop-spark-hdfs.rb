# unpack spark and copy libs to hdfs

remote_file "/opt/spark-#{node['spark']['version']}-bin-hadoop#{node['spark']['hadoop-version']}.tgz" do
    source "http://www.mirrorservice.org/sites/ftp.apache.org/spark/spark-#{node['spark']['version']}/spark-#{node['spark']['version']}-bin-hadoop#{node['spark']['hadoop-version']}.tgz"
    action :create_if_missing
end

execute "unpack spark" do
        command "tar -zxvf /opt/spark-#{node['spark']['version']}-bin-hadoop#{node['spark']['hadoop-version']}.tgz -C /opt/"
        user "root"
end

execute "change spark file permissions" do
        command "chown -R hduser:hadoop /opt/spark-#{node['spark']['version']}-bin-hadoop#{node['spark']['hadoop-version']}"
        user "root"
end

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
