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

execute "enable and start grafana" do
        command "systemctl enable grafana-server && systemctl restart grafana-server"
        user "root"
end

