
remote_file "/opt/livy-server-#{node['livy']['version']}.zip" do
    source "http://archive.cloudera.com/beta/livy/livy-server-#{node['livy']['version']}.zip"
    action :create_if_missing
end

execute "unpack livy" do
        command "unzip -o /opt/livy-server-#{node['livy']['version']}.zip -d /opt"
        user "root"
end

execute "create livy symlink" do
        command "if [ ! -d /opt/livy ]; then ln -s /opt/livy-server-#{node['livy']['version']} /opt/livy; fi"
        user "root"
end

execute "change livy file owner" do
        command "chown -R hduser:hadoop /opt/livy"
        user "root"
end

execute "change livy file permissions" do
        command "chown -R hduser:hadoop /opt/livy-server-#{node['livy']['version']}"
        user "root"
end

template "/opt/livy/conf/log4j.properties" do
        source "log4j.properties.erb"
        mode 0644
        user 'hduser'
        group 'hadoop'
end

directory "/opt/livy/logs" do
        owner "hduser"
        group "hadoop"
        mode  "0755"
end

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

# libs coppied to hdfs by recipe[hadoopi::hadoop-spark-hdfs]
