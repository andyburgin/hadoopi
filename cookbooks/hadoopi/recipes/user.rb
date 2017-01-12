group "hadoop"

user "hduser" do
	username "hduser"
	group "hadoop"
	home '/home/hduser'
	shell '/bin/bash'
end

directory "/home/hduser" do
        owner "hduser"
        group "hadoop"
        mode  "0755"
end

directory "/home/hduser/.ssh" do
	owner "hduser"
	group "hadoop"
	mode  "0700"
end

template "/home/hduser/.ssh/id_rsa" do
        source "id_rsa.erb"
        owner "hduser"
        group "hadoop"
        mode  "0600"
end

template "/home/hduser/.ssh/id_rsa.pub" do
        source "id_rsa.pub.erb"
        owner "hduser"
        group "hadoop"
        mode  "0644"
end

execute "create authorized keys" do
	user "hduser"
	group "hadoop"
	command "cat /home/hduser/.ssh/id_rsa.pub > /home/hduser/.ssh/authorized_keys"
end
