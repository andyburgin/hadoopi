# unpack spark and copy libs to hdfs

remote_file "/opt/spark-#{node['spark']['version']}-bin-hadoop#{node['spark']['hadoop-version']}.tgz" do
    source "https://archive.apache.org/dist/spark/spark-#{node['spark']['version']}/spark-#{node['spark']['version']}-bin-hadoop#{node['spark']['hadoop-version']}.tgz"
    action :create_if_missing
end

execute "unpack spark" do
        command "tar -zxvf /opt/spark-#{node['spark']['version']}-bin-hadoop#{node['spark']['hadoop-version']}.tgz -C /opt/"
        user "root"
end

execute "create spark symlink" do
        command "if [ ! -d /opt/spark ]; then ln -s /opt/spark-#{node['spark']['version']}-bin-hadoop#{node['spark']['hadoop-version']} /opt/spark; fi"
        user "root"
end

execute "change spark file permissions" do
        command "chown -R hduser:hadoop /opt/spark-#{node['spark']['version']}-bin-hadoop#{node['spark']['hadoop-version']}"
        user "root"
end

execute "change spark symlink file permissions" do
        command "chown -R hduser:hadoop /opt/spark"
        user "root"
end

template "/opt/spark/conf/spark-env.sh" do
        source "spark-env.sh.erb"
        mode 0644
        user 'hduser'
        group 'hadoop'
end

template "/opt/spark/conf/spark-defaults.conf" do
        source "spark-defaults.conf.erb"
        mode 0644
        user 'hduser'
        group 'hadoop'
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
