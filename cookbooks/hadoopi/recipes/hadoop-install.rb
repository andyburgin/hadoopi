package "oracle-java8-jdk"

remote_file "/opt/hadoop-2.7.2.armf.tar.gz" do
    source "http://192.168.2.30:8000/hadoop-2.7.2.armf.tar.gz"
    action :create_if_missing
end

execute "unpack hadoop" do
	command "tar -zxvf /opt/hadoop-2.7.2.armf.tar.gz -C /opt/"
	user "root"
end

execute "create hadoop symlink" do
	command "if [ ! -d /opt/hadoop ]; then ln -s /opt/hadoop-2.7.2 /opt/hadoop; fi"
	user "root"
end

execute "change hadoop file permissions" do
	command "chown -R hduser:hadoop /opt/hadoop"
	user "root"
end	

execute "change hadoop file permissions" do
        command "chown -R hduser:hadoop /opt/hadoop-2.7.2"
        user "root"
end

