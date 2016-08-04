user "hue"

remote_file "/opt/hue-3.10.0.armf.tar.gz" do
    source "http://192.168.0.9:8000/hue-3.10.0.armf.tar.gz"
    action :create_if_missing
end

execute "unpack hue" do
        command "tar -zxvf /opt/hue-3.10.0.armf.tar.gz -C /opt/"
        user "root"
end

execute "own hue" do
        command "chown hue.hue -R /opt/hue"
        user "root"
end

