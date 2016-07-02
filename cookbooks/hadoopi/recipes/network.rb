wirepass = ENV["WIREPASS"]
node_ip_address = node["node"]["ip_address"]
node_hostname = node["node"]["hostname"]

template "/etc/wpa_supplicant/wpa_supplicant.conf" do
	source "wpa_supplicant.conf.erb"
	variables(
		:wirepass => wirepass
	)
	mode 0600
	user 'root'
	group 'root'
end

template "/etc/dhcpcd.conf" do
        source "dhcpcd.conf.erb"
        variables(
                :node_ip_address => node_ip_address
        )
        mode 0664
        user 'root'
        group 'netdev'
end


template "/etc/hostname" do
        source "hostname.erb"
        variables(
                :hostname => node_hostname
        )
        mode 0644
        user 'root'
        group 'root'
end

# execute "hostname #{fqdn}" do
