user "oozie"

package "zip"

remote_file "/opt/oozie-#{node['oozie']['version']}.armf.tar.gz" do
    source "http://192.168.0.9:8000/oozie-#{node['oozie']['version']}.armf.tar.gz"
    action :create_if_missing
end

execute "unpack oozie" do
        command "tar -zxvf /opt/oozie-#{node['oozie']['version']}.armf.tar.gz -C /opt/"
        user "root"
end

execute "create oozie symlink" do
        command "if [ ! -d /opt/oozie ]; then ln -s /opt/oozie-#{node['oozie']['version']} /opt/oozie; fi"
        user "root"
end

execute "Chown oozie" do
        command "chown oozie.oozie -R /opt/oozie"
        user "root"
end

execute "Chown oozie-#{node['oozie']['version']}" do
        command "chown -R oozie.oozie /opt/oozie-#{node['oozie']['version']}"
        user "root"
end

# create oozie config files
template "/opt/oozie/conf/oozie-site.xml" do
        source "oozie-site.xml.erb"
        mode 0644
        user 'oozie'
        group 'oozie'
end

template "/opt/oozie/conf/oozie-env.sh" do
        source "oozie-env.sh.erb"
        mode 0644
        user 'oozie'
        group 'oozie'
        variables(
             :maxmem => node['hadoop']['maxmem']
        )
end

# create war file
execute "prepare oozie war file" do
        command "cd /opt/oozie && bin/oozie-setup.sh prepare-war"
        user "oozie"
end

# create ozzie db
execute "create oozie db" do
        command "cd /opt/oozie && bin/ooziedb.sh create -sqlfile oozie.sql -run"
        user "oozie"
        returns [0,1]
end 

# create sharelib
execute "start hdfs for config" do
        command "/opt/hadoop/sbin/start-dfs.sh"
        user "hduser"
        returns [0,1]
end

execute "create oozie home" do
        command "/opt/hadoop/bin/hadoop fs -mkdir -p /user/oozie"
        user "hduser"
        retry_delay 5
        retries 5
end

execute "Chown oozie home" do
        command "/opt/hadoop/bin/hadoop fs -chown oozie:supergroup /user/oozie"
        user "hduser"
        retry_delay 5
        retries 5
end

execute "create oozie shared lib on hdfs" do
        command "cd /opt/oozie && bin/oozie-setup.sh sharelib create -fs hdfs://master01:54310"
        user "oozie"
end

execute "Chmod /tmp" do
        command "/opt/hadoop/bin/hadoop fs -chmod 777 /tmp"
        user "hduser"
        retry_delay 5
        retries 5
end

execute "stop hdfs" do
        command "/opt/hadoop/sbin/stop-dfs.sh"
        user "hduser"
end

