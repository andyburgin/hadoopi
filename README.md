# hadoopi

This repo holds the Chef code for the configuration of a Raspberry Pi 3 cluster running hadoop

The cluster will consist of a single master node and 4 worker nodes


Prerequisites:

Boot node to console
sudo raspi-config
Split memory 16MB
SSHD on
Apply and reboot

Login again, this time via ssh 
sudo apt-get update
sudo apt-get install git
sudo apt-get install chef


Running Chef:

export WIREPASS=abc123
chef-solo -c solo.rb -j master01.json
