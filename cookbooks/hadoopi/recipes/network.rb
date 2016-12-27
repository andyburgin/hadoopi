wiressid = ENV["WIRESSID"]
wirepass = ENV["WIREPASS"]
node_ip_address = node["node"]["ip_address"]
node_hostname = node["node"]["hostname"]
hosts = node["hosts"]

template "/etc/wpa_supplicant/wpa_supplicant.conf" do
	source "wpa_supplicant.conf.erb"
	variables(
                :wiressid => wiressid,
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

execute "set hostname" do
	command "hostnamectl set-hostname #{node_hostname}"
end

template "/etc/hosts" do
        source "hosts.erb"
        variables(
                :hostname => node_hostname,
		:hosts => hosts
        )
        mode 0644
        user 'root'
        group 'root'
end

template "/etc/ssh/ssh_config" do
        source "ssh_config.erb"
        mode 0644
        user 'root'
        group 'root'
end

execute "restart networking" do
        command "service networking restart"
end

execute "bring up wlan0" do
        command "ifup wlan0"
end

package "nscd" do
	action :install
end
