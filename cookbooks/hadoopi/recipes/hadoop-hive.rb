remote_file "/opt/apache-hive-#{node['hive']['version']}-bin.tar.gz" do
    source "https://archive.apache.org/dist/hive/hive-#{node['hive']['version']}/apache-hive-#{node['hive']['version']}-bin.tar.gz"
    action :create_if_missing
end

execute "unpack hive" do
        command "tar -zxvf /opt/apache-hive-#{node['hive']['version']}-bin.tar.gz -C /opt/"
        user "root"
end

execute "create hive symlink" do
        command "if [ ! -d /opt/hive ]; then ln -s /opt/apache-hive-#{node['hive']['version']}-bin /opt/hive; fi"
        user "root"
end

execute "change hive file permissions" do
        command "chown -R hduser:hadoop /opt/hive"
        user "root"
end

execute "change hive file permissions" do
        command "chown -R hduser:hadoop /opt/apache-hive-#{node['hive']['version']}-bin"
        user "root"
end

