user "hue"

remote_file "/opt/apache-hive-2.1.0-bin.tar.gz" do
    source "http://www.mirrorservice.org/sites/ftp.apache.org/hive/stable-2/apache-hive-2.1.0-bin.tar.gz"
    action :create_if_missing
end

execute "unpack hive" do
        command "tar -zxvf /opt/apache-hive-2.1.0-bin.tar.gz -C /opt/"
        user "root"
end

execute "create hive symlink" do
        command "if [ ! -d /opt/hive ]; then ln -s /opt/apache-hive-2.1.0-bin /opt/hive; fi"
        user "root"
end

execute "change hive file permissions" do
        command "chown -R hduser:hadoop /opt/hive"
        user "root"
end

execute "change hive file permissions" do
        command "chown -R hduser:hadoop /opt/apache-hive-2.1.0-bin"
        user "root"
end





