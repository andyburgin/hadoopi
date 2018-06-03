
# bug in chef < 11.14 that causes issues with remote_file, falling back to using wget
execute "download process-exporter" do
        command "wget https://github.com/ncabatoff/process-exporter/releases/download/v#{node['processexporter']['version']}/process-exporter-#{node['processexporter']['version']}.linux-armv7.tar.gz -P /opt"
        user "root"
end

execute "unpack process-exporter" do
        command "tar -zxvf /opt/process-exporter-#{node['processexporter']['version']}.linux-armv7.tar.gz -C /opt/"
        user "root"
end

execute "create process-exporter symlink" do
        command "if [ ! -d /opt/process-exporter ]; then ln -s /opt/process-exporter-#{node['processexporter']['version']}.linux-armv7 /opt/process-exporter; fi"
        user "root"
end

directory '/opt/process-exporter/logs' do
  action :create
end

