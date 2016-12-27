
remote_file "/opt/solr-#{node['solr']['version']}.tgz" do
    source "http://archive.apache.org/dist/lucene/solr/#{node['solr']['version']}/solr-#{node['solr']['version']}.tgz"
    action :create_if_missing
end

execute "unpack solr" do
        command "tar -zxvf /opt/solr-#{node['solr']['version']}.tgz -C /opt/"
        user "root"
end

execute "create solr symlink" do
        command "if [ ! -d /opt/solr ]; then ln -s /opt/solr-#{node['solr']['version']} /opt/solr; fi"
        user "root"
end

execute "Chown solr" do
        command "chown hduser.hadoop -R /opt/solr"
        user "root"
end

execute "Chown solr-#{node['solr']['version']}" do
        command "chown -R hduser.hadoop /opt/solr-#{node['solr']['version']}"
        user "root"
end

# hdfs folders on hdfs setup by recipe[hadoopi::hadoop-solr-hdfs]
