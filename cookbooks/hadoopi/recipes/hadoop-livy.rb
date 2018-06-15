
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