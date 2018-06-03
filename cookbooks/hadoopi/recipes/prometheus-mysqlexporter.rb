
# bug in chef < 11.14 that causes issues with remote_file, falling back to using wget
execute "download mysql exporter" do
        command "wget https://github.com/prometheus/mysqld_exporter/releases/download/v#{node['mysqlexporter']['version']}/mysqld_exporter-#{node['mysqlexporter']['version']}.linux-armv7.tar.gz -P /opt"
        user "root"
end

execute "unpack mysqlexporter" do
        command "tar -zxvf /opt/mysqld_exporter-#{node['mysqlexporter']['version']}.linux-armv7.tar.gz -C /opt/"
        user "root"
end

execute "create mysqlexporter symlink" do
        command "if [ ! -d /opt/mysqld_exporter ]; then ln -s /opt/mysqld_exporter-#{node['mysqlexporter']['version']}.linux-armv7 /opt/mysqld_exporter; fi"
        user "root"
end

directory '/opt/mysqld_exporter/log' do
  action :create
end

execute "create mysql exporter user" do
        command "mysql -u root -e \"CREATE USER 'exporter'@'localhost' IDENTIFIED BY '#{node['mysqlexporter']['password']}';\""
        user "root"
end

execute "Grant mysql exporter user access to metrics" do
        command "mysql -u root -e \"GRANT PROCESS, REPLICATION CLIENT, SELECT ON *.* TO 'exporter'@'localhost';\""
        user "root"
end

execute "Make mysql exporter user perms take effect" do
        command "mysql -u root -e \"FLUSH PRIVILEGES;\""
        user "root"
end
