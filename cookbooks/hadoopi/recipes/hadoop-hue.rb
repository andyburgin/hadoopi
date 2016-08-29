user "hue"

package "libxml2"
package "libxslt-dev"

remote_file "/opt/hue-3.10.0.armf.tar.gz" do
    source "http://192.168.0.9:8000/hue-3.10.0.armf.tar.gz"
    action :create_if_missing
end

execute "unpack hue" do
        command "tar -zxvf /opt/hue-3.10.0.armf.tar.gz -C /opt/"
        user "root"
end

execute "Chown hue" do
        command "chown hue.hue -R /opt/hue"
        user "root"
end

template "/opt/hue/desktop/conf/hue.ini" do
        source "hue.ini.erb"
        mode 0644
        user 'hue'
        group 'hue'
        variables( 
             :hue_secretkey => node['hue']['secretkey']
        )
end

# install mysql for hue data
package "mysql-server"
package "libmysqlclient-dev"
package "libmysql-java"

execute "Create mysql db" do
        command "mysql -u root -e \"CREATE DATABASE hue;\""
        user "root"
        returns [0,1]
end

execute "Create mysql hue user" do
        command "mysql -u root -e \"CREATE USER hue IDENTIFIED BY 'huepassword';\""
        user "root"
	returns [0,1]
end

execute "Grant hue user access to mysql db" do
        command "mysql -u root -e \"GRANT ALL PRIVILEGES on *.* to 'hue'@'localhost' WITH GRANT OPTION; GRANT ALL on hue.* to 'hue'@'localhost' IDENTIFIED BY 'huepassword'; FLUSH PRIVILEGES;\""
        user "root"
end

execute "create db structure" do
	command "cd /opt/hue && /opt/hue/build/env/bin/hue syncdb --noinput"
	user "hue"
end

execute "sync db structure" do
        command "cd /opt/hue && /opt/hue/build/env/bin/hue migrate"
        user "hue"
end

