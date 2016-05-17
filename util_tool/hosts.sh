#!/bin/bash


sudo cp /etc/hosts /etc/hosts.backup

#echo "192.168.33.10  master" > ./hosts
#echo "192.168.33.11  slave" >> ./hosts
#echo "127.0.0.1      localhost" >> ./hosts

cat << EOF > ./hosts
192.168.33.10  master
192.168.33.11  slave
127.0.0.1      localhost
EOF

sudo mv ./hosts /etc/hosts
