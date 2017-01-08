# install hadoop  packages
package "oracle-java8-jdk"
package "libsnappy-java"
package "libssl-dev"
package "vim"
package "r-base"

remote_file "/opt/hadoop-#{node['hadoop']['version']}.armf.tar.gz" do
    source "#{node['hadoop']['repobase']}/hadoop-#{node['hadoop']['version']}.armf.tar.gz"
    action :create_if_missing
end

execute "unpack hadoop" do
	command "tar -zxvf /opt/hadoop-#{node['hadoop']['version']}.armf.tar.gz -C /opt/"
	user "root"
end

# tidy up incompatible jline vers
execute "tidy up incompatible jline vers" do
        command "find /opt/hadoop-#{node['hadoop']['version']} -name \"jline-0.9.94.jar\" -exec rm -f {} \\;"
        user "hduser"
end

execute "create hadoop symlink" do
	command "if [ ! -d /opt/hadoop ]; then ln -s /opt/hadoop-#{node['hadoop']['version']} /opt/hadoop; fi"
	user "root"
end

execute "change hadoop file permissions" do
	command "chown -R hduser:hadoop /opt/hadoop"
	user "root"
end	

execute "change hadoop file permissions" do
        command "chown -R hduser:hadoop /opt/hadoop-#{node['hadoop']['version']}"
        user "root"
end

# update environment vars
template "/opt/hadoop/etc/hadoop/hadoop-env.sh" do
        source "hadoop-env.sh.erb"
        mode 0644
        user 'hduser'
        group 'hadoop'
        variables(
             :maxmem => node['hadoop']['maxmem']
        )
end

template "/opt/hadoop/etc/hadoop/mapred-env.sh" do
        source "mapred-env.sh.erb"
        mode 0644
        user 'hduser'
        group 'hadoop'
        variables(
             :maxmem => node['hadoop']['maxmem']
        )
end

template "/opt/hadoop/etc/hadoop/yarn-env.sh" do
        source "yarn-env.sh.erb"
        mode 0644
        user 'hduser'
        group 'hadoop'
        variables(
             :maxmem => node['hadoop']['maxmem']
        )
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


template "/opt/hadoop/etc/hadoop/masters" do
        source "masters.erb"
        mode 0644
        user 'hduser'
        group 'hadoop'
end

template "/opt/hadoop/etc/hadoop/slaves" do
        source "slaves.erb"
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

