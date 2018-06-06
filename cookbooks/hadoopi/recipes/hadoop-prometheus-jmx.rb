# install jmx exporter
directory '/opt/jmxexporter' do
  action :create
end

directory '/opt/jmxexporter/lib' do
  action :create
end

directory '/opt/jmxexporter/etc' do
  action :create
end

remote_file "/opt/jmxexporter/lib/jmx_prometheus_javaagent-#{node['jmxexporter']['version']}.jar" do
    source "https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/#{node['jmxexporter']['version']}/jmx_prometheus_javaagent-#{node['jmxexporter']['version']}.jar"
    action :create_if_missing
end

# replace hadoop binary files including jmx exporter references
template "/opt/hadoop/bin/hdfs" do
        source "hdfs.erb"
        mode 0755
        user 'hduser'
        group 'hadoop'
end

template "/opt/hadoop/bin/yarn" do
        source "yarn.erb"
        mode 0755
        user 'hduser'
        group 'hadoop'
end

template "/opt/hadoop/sbin/mr-jobhistory-daemon.sh" do
        source "mr-jobhistory-daemon.sh.erb"
        mode 0755
        user 'hduser'
        group 'hadoop'
end

template "/opt/hbase/bin/hbase" do
        source "hbase.erb"
        mode 0755
        user 'hduser'
        group 'hadoop'
        only_if { ::File.exist?('/opt/hbase') }
end

# jmx exporter templates
template "/opt/jmxexporter/etc/prometheus_hbase_jmx_config.yaml" do
        source "prometheus_hbase_jmx_config.yaml.erb"
        mode 0644
end

template "/opt/jmxexporter/etc/prometheus_hdfs_datanode_jmx_exporter.yaml" do
        source "prometheus_hdfs_datanode_jmx_exporter.yaml.erb"
        mode 0644
end

template "/opt/jmxexporter/etc/prometheus_hdfs_namenode_jmx_exporter.yaml" do
        source "prometheus_hdfs_namenode_jmx_exporter.yaml.erb"
        mode 0644
end

template "/opt/jmxexporter/etc/prometheus_hdfs_secondarynamenode_jmx_exporter.yaml" do
        source "prometheus_hdfs_secondarynamenode_jmx_exporter.yaml.erb"
        mode 0644
end

template "/opt/jmxexporter/etc/prometheus_mapreduce_history_jmx_exporter.yaml" do
        source "prometheus_mapreduce_history_jmx_exporter.yaml.erb"
        mode 0644
end

template "/opt/jmxexporter/etc/prometheus_yarn_nodemanager_jmx_exporter.yaml" do
        source "prometheus_yarn_nodemanager_jmx_exporter.yaml.erb"
        mode 0644
end

template "/opt/jmxexporter/etc/prometheus_yarn_resourcemanager_jmx_exporter.yaml" do
        source "prometheus_yarn_resourcemanager_jmx_exporter.yaml.erb"
        mode 0644
end

template "/opt/prometheus/prometheus.yml" do
        source "prometheus.yml.jmx.erb"
        mode 0644
        user 'root'
        group 'root'
end

