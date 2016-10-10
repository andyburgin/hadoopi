
remote_file "/opt/livy-server-#{node['livy']['version']}.zip" do
    source "http://archive.cloudera.com/beta/livy/livy-server-#{node['livy']['version']}.zip"
    action :create_if_missing
end

execute "unpack spark" do
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

template "/opt/livy/conf/livy.conf" do
        source "livy.conf.erb"
        mode 0644
        user 'hduser'
        group 'hadoop'
end


remote_file "/opt/spark-#{node['spark']['version']}-bin-hadoop#{node['spark']['hadoop-version']}.tgz" do
    source "http://www.mirrorservice.org/sites/ftp.apache.org/spark/spark-#{node['spark']['version']}/spark-#{node['spark']['version']}-bin-hadoop#{node['spark']['hadoop-version']}.tgz"
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
        command "chown -R hduser:hadoop /opt/spark-#{node['spark']['version']}-bin-hadoop2.6"
        user "root"
end

execute "change spark file permissions" do
        command "chown -R hduser:hadoop /opt/spark-#{node['spark']['version']}-bin-hadoop2.6"
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

