
remote_file "/opt/pig-#{node['pig']['version']}.tar.gz" do
    source "http://www.mirrorservice.org/sites/ftp.apache.org/pig/pig-#{node['pig']['version']}/#{node['pig']['version']}.tar.gz"
    action :create_if_missing
end

execute "unpack pig" do
        command "tar -zxvf /opt/pig-#{node['pig']['version']}.tar.gz -C /opt/"
        user "root"
end

execute "create pig symlink" do
        command "if [ ! -d /opt/pig ]; then ln -s /opt/pig-#{node['pig']['version']} /opt/pig; fi"
        user "root"
end

execute "change pig file permissions" do
        command "chown -R hduser:hadoop /opt/pig"
        user "root"
end

execute "change pig file permissions" do
        command "chown -R hduser:hadoop /opt/pig-#{node['pig']['version']}"
        user "root"
end





