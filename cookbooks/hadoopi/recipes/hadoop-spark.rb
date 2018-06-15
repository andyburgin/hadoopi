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

# libs coppied to hdfs by recipe[hadoopi::hadoop-spark-hdfs]
