# install sqoop
remote_file "/opt/sqoop-#{node['sqoop']['version']}-bin-hadoop200.tar.gz" do
        source "http://archive.apache.org/dist/sqoop/#{node['sqoop']['version']}/sqoop-#{node['sqoop']['version']}-bin-hadoop200.tar.gz"
        action :create_if_missing
end

execute "unpack sqoop" do
        command "tar -zxvf /opt/sqoop-#{node['sqoop']['version']}-bin-hadoop200.tar.gz -C /opt/"
        user "root"
end

execute "create sqoop symlink" do
        command "if [ ! -d /opt/sqoop ]; then ln -s /opt/sqoop-#{node['sqoop']['version']}-bin-hadoop200 /opt/sqoop; fi"
        user "root"
end

execute "change sqoop symlink owner" do
        command "chown -R hduser:hadoop /opt/sqoop"
        user "root"
end

execute "change sqoop file owner" do
        command "chown -R hduser:hadoop /opt/sqoop-#{node['sqoop']['version']}-bin-hadoop200"
        user "root"
end

template "/opt/sqoop/server/conf/sqoop.properties" do
        source "sqoop.properties.erb"
        mode 0644
        user 'hduser'
        group 'hadoop'
end

template "/opt/sqoop/server/conf/catalina.properties" do
        source "catalina.properties.erb"
        mode 0644
        user 'hduser'
        group 'hadoop'
end

# install mysql driver
remote_file "/opt/mysql-connector-java-#{node['sqoopmysql']['version']}.tar.gz" do
        source "https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-#{node['sqoopmysql']['version']}.tar.gz"
        action :create_if_missing
end

execute "unpack sqoop mysql driver" do
        command "tar -zxvf /opt/mysql-connector-java-#{node['sqoopmysql']['version']}.tar.gz -C /opt/"
        user "root"
end

## copy driver to lib
remote_file "copy mysql jar into sqoop server lib" do
        path "/opt/sqoop/server/lib/mysql-connector-java-#{node['sqoopmysql']['version']}-bin.jar"
        source "file:///opt/mysql-connector-java-#{node['sqoopmysql']['version']}/mysql-connector-java-#{node['sqoopmysql']['version']}-bin.jar"
        mode 0644
        user 'hduser'
        group 'hadoop'
end
