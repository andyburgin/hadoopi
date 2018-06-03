remote_file "/opt/hbase-#{node['hbase']['version']}-bin.tar.gz" do
    source "https://archive.apache.org/dist/hbase/#{node['hbase']['version']}/hbase-#{node['hbase']['version']}-bin.tar.gz"
    action :create_if_missing
end

execute "unpack hbase" do
        command "tar -zxvf /opt/hbase-#{node['hbase']['version']}-bin.tar.gz -C /opt/"
        user "root"
end

execute "create hbase symlink" do
        command "if [ ! -d /opt/hbase ]; then ln -s /opt/hbase-#{node['hbase']['version']} /opt/hbase; fi"
        user "root"
end

execute "change hbase symlink file permissions" do
        command "chown -R hduser:hadoop /opt/hbase"
        user "root"
end

execute "change hbase file permissions" do
        command "chown -R hduser:hadoop /opt/hbase-#{node['hbase']['version']}"
        user "root"
end

template "/opt/hbase/conf/hbase-env.sh" do
        source "hbase-env.sh.erb"
        mode 0644
        user 'hduser'
        group 'hadoop'
        variables(
             :maxmem => node['hadoop']['maxmem']
        )
end

template "/opt/hbase/conf/hbase-site.xml" do
        source "hbase-site.xml.erb"
        mode 0644
        user 'hduser'
        group 'hadoop'
end

directory "/opt/hbase/datdDir" do
        owner "hduser"
        group "hadoop"
        mode  "0777"
end

