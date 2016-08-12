remote_file "/opt/hbase-1.2.2-bin.tar.gz" do
    source "http://www.mirrorservice.org/sites/ftp.apache.org/hbase/stable/hbase-1.2.2-bin.tar.gz"
    action :create_if_missing
end

execute "unpack hbase" do
        command "tar -zxvf /opt/hbase-1.2.2-bin.tar.gz -C /opt/"
        user "root"
end

execute "create hbase symlink" do
        command "if [ ! -d /opt/hbase ]; then ln -s /opt/hbase-1.2.2 /opt/hbase; fi"
        user "root"
end

execute "change hbase file permissions" do
        command "chown -R hduser:hadoop /opt/hbase"
        user "root"
end

execute "change hbase file permissions" do
        command "chown -R hduser:hadoop /opt/hbase-1.2.2"
        user "root"
end

