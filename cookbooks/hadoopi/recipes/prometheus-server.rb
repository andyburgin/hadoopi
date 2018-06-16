
# bug in chef < 11.14 that causes issues with remote_file, falling back to using wget
execute "download prometheus" do
        command "wget https://github.com/prometheus/prometheus/releases/download/v#{node['prometheus']['version']}/prometheus-#{node['prometheus']['version']}.linux-armv7.tar.gz -P /opt"
        user "root"
end

execute "unpack prometheus" do
        command "tar -zxvf /opt/prometheus-#{node['prometheus']['version']}.linux-armv7.tar.gz -C /opt/"
        user "root"
end

execute "create prometheus symlink" do
        command "if [ ! -d /opt/prometheus ]; then ln -s /opt/prometheus-#{node['prometheus']['version']}.linux-armv7 /opt/prometheus; fi"
        user "root"
end

template "/opt/prometheus/prometheus.yml" do
        source "prometheus.yml.erb"
        mode 0644
        user 'root'
        group 'root'
end

# no systemd_unit resource till chef 12.11, fall back to template and systemctl 
template "/etc/systemd/system/prometheus.service" do
        source "prometheus.service.erb"
        mode 0644
        user 'root'
        group 'root'
end

execute "enable and start prometheus" do
        command "systemctl daemon-reload && systemctl enable prometheus && systemctl restart prometheus"
        user "root"
end

