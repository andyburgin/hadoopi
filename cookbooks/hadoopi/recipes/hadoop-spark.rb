
remote_file "/opt/livy-server-0.2.0.zip" do
    source "http://archive.cloudera.com/beta/livy/livy-server-0.2.0.zip"
    action :create_if_missing
end

execute "unpack spark" do
        command "unzip -o /opt/livy-server-0.2.0.zip -d /opt"
        user "root"
end

execute "create livy symlink" do
        command "if [ ! -d /opt/livy ]; then ln -s /opt/livy-server-0.2.0 /opt/livy; fi"
        user "root"
end

execute "change livy file owner" do
        command "chown -R hduser:hadoop /opt/livy"
        user "root"
end

execute "change livy file permissions" do
        command "chown -R hduser:hadoop /opt/livy-server-0.2.0"
        user "root"
end

template "/opt/livy/conf/livy.conf" do
        source "livy.conf.erb"
        mode 0644
        user 'hduser'
        group 'hadoop'
end


remote_file "/opt/spark-1.6.2-bin-hadoop2.6.tgz" do
    source "http://www.mirrorservice.org/sites/ftp.apache.org/spark/spark-1.6.2/spark-1.6.2-bin-hadoop2.6.tgz"
    action :create_if_missing
end

execute "unpack spark" do
        command "tar -zxvf /opt/spark-1.6.2-bin-hadoop2.6.tgz -C /opt/"
        user "root"
end

execute "create spark symlink" do
        command "if [ ! -d /opt/spark ]; then ln -s /opt/spark-1.6.2-bin-hadoop2.6 /opt/spark; fi"
        user "root"
end

execute "change spark file permissions" do
        command "chown -R hduser:hadoop /opt/spark-1.6.2-bin-hadoop2.6"
        user "root"
end

execute "change spark file permissions" do
        command "chown -R hduser:hadoop /opt/spark-1.6.2-bin-hadoop2.6"
        user "root"
end

template "/opt/spark/conf/spark-env.sh do
        source "spark-env.sh.erb"
        mode 0644
        user 'hduser'
        group 'hadoop'
end

template "/opt/spark/conf/spark-defaults.conf" do
        source "spark-defaults.conf.erb"
        mode 0644
        user 'hduser'
        group 'hadoop'
end

