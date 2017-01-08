remote_file "/opt/hbase-#{node['hbase']['version']}-bin.tar.gz" do
    source "http://www.mirrorservice.org/sites/ftp.apache.org/hbase/stable/hbase-#{node['hbase']['version']}-bin.tar.gz"
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

execute "change hbase file permissions" do
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
