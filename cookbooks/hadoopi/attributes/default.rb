#hue
default['hue']['secretkey']="qpbdxoewsqlkhztybvfidtvwekftusgdlofbcfghaswuicmqp"
default['hadoop']['maxmem']=512
default['hadoop']['repobase']="http://10.0.0.9:8000/"

#versions
default['hadoop']['version'] = '2.6.4'
default['zookeper']['version'] = '3.4.8'
default['livy']['version'] = '0.2.0'
default['spark']['version'] = '1.6.2'
default['spark']['hadoop-version'] = '2.6'
default['hue']['version']  = '3.11.0'
default['hbase']['version'] = '1.2.4'
default['pig']['version'] = '0.12.1'
default['hive']['version'] = '1.2.1'
default['oozie']['version'] = '4.3.0'
default['sqoop']['version'] = '1.99.4'
default['sqoopmysql']['version'] = '5.1.40'
default['solr']['version'] = '4.10.4'

#networking
default['hosts'] =  {
    "master01" => "10.0.0.11",
    "master02" => "10.0.0.12",
    "worker01" => "10.0.0.21",
    "worker02" => "10.0.0.22",
    "worker03" => "10.0.0.23"
}
default['gateway'] = '10.0.0.1'
