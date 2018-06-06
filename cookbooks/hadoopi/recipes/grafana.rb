execute "add grafana repo" do
        command "echo \"deb https://dl.bintray.com/fg2it/deb jessie main\" | sudo tee -a /etc/apt/sources.list.d/grafana.list"
        user "root"
end

execute "update repos" do
        command "apt-get update"
        user "root"
end

execute "install package" do
        command "apt-get -y --force-yes install grafana"
        user "root"
end

# grafana datasource
template "/etc/grafana/provisioning/datasources/prometheus.yaml" do
        source "prometheus.yaml.erb"
        mode 0644
end

# grafana dashboards
template "/etc/grafana/provisioning/dashboards/hadoopi.yaml" do
        source "hadoopi.yaml.erb"
        mode 0644
end

template "/etc/grafana/provisioning/dashboards/Hadoop.json" do
        source "Hadoop.json.erb"
        mode 0644
end

template "/etc/grafana/provisioning/dashboards/HBase.json" do
        source "HBase.json.erb"
        mode 0644
end

template "/etc/grafana/provisioning/dashboards/JVM.json" do
        source "JVM.json.erb"
        mode 0644
end

template "/etc/grafana/provisioning/dashboards/MySQL.json" do
        source "MySQL.json.erb"
        mode 0644
end

template "/etc/grafana/provisioning/dashboards/Named_processes.json" do
        source "Named_processes.json.erb"
        mode 0644
end

template "/etc/grafana/provisioning/dashboards/Node_Exporter_Full.json" do
        source "Node_Exporter_Full.json.erb"
        mode 0644
end

template "/etc/grafana/provisioning/dashboards/Node_Exporter_Server_Metrics.json" do
        source "Node_Exporter_Server_Metrics.json.erb"
        mode 0644
end

template "/etc/grafana/provisioning/dashboards/Zookeeper.json" do
        source "Zookeeper.json.erb"
        mode 0644
end

# enable and start grafana
execute "enable and start grafana" do
        command "systemctl enable grafana-server && systemctl restart grafana-server"
        user "root"
end

