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
