
remote_file "/opt/pig-0.15.0.tar.gz" do
    source "http://www.mirrorservice.org/sites/ftp.apache.org/pig/pig-0.15.0/pig-0.15.0.tar.gz"
    action :create_if_missing
end

execute "unpack pig" do
        command "tar -zxvf /opt/pig-0.15.0.tar.gz -C /opt/"
        user "root"
end

execute "create pig symlink" do
        command "if [ ! -d /opt/pig ]; then ln -s /opt/pig-0.15.0 /opt/pig; fi"
        user "root"
end

execute "change pig file permissions" do
        command "chown -R hduser:hadoop /opt/pig"
        user "root"
end

execute "change pig file permissions" do
        command "chown -R hduser:hadoop /opt/pig-0.15.0"
        user "root"
end





