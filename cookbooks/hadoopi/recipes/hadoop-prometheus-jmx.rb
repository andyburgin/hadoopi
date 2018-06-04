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

template "/opt/hadoop/etc/hadoop/hadoop-env.sh" do
        source "hadoop-env.sh.erb"
        mode 0644
        user 'hduser'
        group 'hadoop'
        variables(
             :maxmem => node['hadoop']['maxmem']
        )
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

