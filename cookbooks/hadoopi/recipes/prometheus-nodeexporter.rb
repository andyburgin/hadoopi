
# bug in chef < 11.14 that causes issues with remote_file, falling back to using wget
execute "download node_exporter" do
        command "wget https://github.com/prometheus/node_exporter/releases/download/v#{node['nodeexporter']['version']}/node_exporter-#{node['nodeexporter']['version']}.linux-armv7.tar.gz -P /opt"
        user "root"
end

execute "unpack node_exporter" do
        command "tar -zxvf /opt/node_exporter-#{node['nodeexporter']['version']}.linux-armv7.tar.gz -C /opt/"
        user "root"
end

execute "create node_exporter symlink" do
        command "if [ ! -d /opt/node_exporter ]; then ln -s /opt/node_exporter-#{node['nodeexporter']['version']}.linux-armv7 /opt/node_exporter; fi"
        user "root"
end


# no systemd_unit resource till chef 12.11, fall back to template and systemctl 
template "/etc/systemd/system/node_exporter.service" do
        source "node_exporter.service.erb"
        mode 0644
        user 'root'
        group 'root'
end

execute "enable and start node exporter" do
        command "systemctl daemon-reload && systemctl enable node_exporter && systemctl start node_exporter"
        user "root"
end
