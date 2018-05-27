group "hadoop"

template "/etc/dphys-swapfile" do
        source "dphys-swapfile.erb"
        mode 0644
        user 'root'
        group 'root'
        variables(
             :swapsize => node['swapsize']
        )
end

execute "set swap size" do
        command "/etc/init.d/dphys-swapfile restart"
        user "root"
end
