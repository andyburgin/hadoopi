# install hadoop  packages
package "oracle-java8-jdk"
package "libsnappy-java"
package "libssl-dev"

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

# update environment vars
template "/opt/hadoop/etc/hadoop/hadoop-env.sh" do
        source "hadoop-env.sh.erb"
        mode 0644
        user 'hduser'
        group 'hadoop'
end

template "/etc/bash.bashrc" do
        source "bash.bashrc.erb"
        mode 0644
        user 'root'
        group 'root'
end

# create hadoop config files
template "/opt/hadoop/etc/hadoop/core-site.xml" do
        source "core-site.xml.erb"
        mode 0644
        user 'hduser'
        group 'hadoop'
end

template "/opt/hadoop/etc/hadoop/hdfs-site.xml" do
        source "hdfs-site.xml.erb"
        mode 0644
        user 'hduser'
        group 'hadoop'
end

template "/opt/hadoop/etc/hadoop/yarn-site.xml" do
        source "yarn-site.xml.erb"
        mode 0644
        user 'hduser'
        group 'hadoop'
end

template "/opt/hadoop/etc/hadoop/mapred-site.xml" do
        source "mapred-site.xml.erb"
        mode 0644
        user 'hduser'
        group 'hadoop'
end

# create hdfs file system
directory "/hdfs" do
        mode  "0777"
end

directory "/hdfs/tmp" do
        owner "hduser"
        group "hadoop"
        mode  "0750"
        recursive true
end

# format name node, allow return code of 1 incase already formatted
execute "format namenode" do
        command "/opt/hadoop/bin/hadoop namenode -format -nonInteractive"
        user "hduser"
        returns [0,1]
end
