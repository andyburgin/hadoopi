
remote_file "/opt/zookeeper-3.4.8.tar.gz" do
    source "http://www.mirrorservice.org/sites/ftp.apache.org/zookeeper/stable/zookeeper-3.4.8.tar.gz"
    action :create_if_missing
end

execute "unpack zookeeper" do
        command "tar -zxvf /opt/zookeeper-3.4.8.tar.gz  -C /opt/"
        user "root"
end

execute "create zookeeper symlink" do
        command "if [ ! -d /opt/zookeeper ]; then ln -s /opt/zookeeper-3.4.8 /opt/zookeeper; fi"
        user "root"
end

execute "Chown zookeeper" do
        command "chown hduser.hadoop -R /opt/zookeeper"
        user "root"
end

execute "Chown zookeeper binaries" do
        command "chown -R hduser.hadoop /opt/zookeeper-3.4.8"
        user "root"
end

directory "/opt/zookeeper/data" do
        owner "hduser"
        group "hadoop"
        mode  "0755"
end

directory "/opt/zookeeper/log" do
        owner "hduser"
        group "hadoop"
        mode  "0755"
end

# create zookeeper config files
template "/opt/zookeeper/conf/zoo.cfg" do
        source "zoo.cfg.erb"
        mode 0644
        user "hduser"
        group "hadoop"
end

