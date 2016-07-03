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
	mode  "0755"
end

execute "generate ssh keys" do
	user "hduser"
	group "hadoop"
	command "ssh-keygen -t rsa -f /home/hduser/.ssh/id_rsa -q -P \"\""
end

execute "create authorized keys" do
	user "hduser"
	group "hadoop"
	command "cat /home/hduser/.ssh/id_rsa.pub > /home/hduser/.ssh/authorized_keys"
end
