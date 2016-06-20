#!/bin/bash
ret=$(whoami)
if [ $ret != "hadoop" ];then
        echo "[ERROR0] please login as hadoop "
        echo "> sudo su - hadoop  "
        exit 1 ;
fi


cd ~

ssh-keygen -t rsa -f ~/.ssh/id_rsa -q -P ""

ssh-copy-id master

ret=$?
if [ $ret -ne 0 ];then
        echo "[ERROR1] exchange key to master error ! stopping. "
        exit 1 ;
fi

ssh-copy-id slave

ret=$?
if [ $ret -ne 0 ];then
        echo "[ERROR2] exchange key to slave error ! stopping. "
        exit 1 ;
fi

tar -zxf /opt/hadoop-2.6.0-cdh5.5.1.tar.gz

mv hadoop-2.6.0-cdh5.5.1 hadoop

#cp -rf /opt/nchc_vagrant ./
git clone https://github.com/waue0920/nchc_vagrant.git

sed -i 's/java-7-openjdk-amd64/java-8-oracle/g' ./nchc_vagrant/hadoop_conf/hadoop-env.sh

sed -i 's/java-7-openjdk-amd64/java-8-oracle/g' ./nchc_vagrant/hadoop_conf/hadoop-config.sh


bash ./nchc_vagrant/util_tool/setup_hadoop_conf.sh
ret=$?
if [ $ret -ne 0 ];then
        echo "[ERROR3] failed to setup hadoop config ! stopping. "
        exit 1 ;
fi


#scp -r /home/hadoop/hadoop slave:/home/hadoop
tar -zcf ./hadoop.tar.gz ./hadoop
scp ./hadoop.tar.gz slave:~/
ssh slave "tar -xzf ~/hadoop.tar.gz"
ret=$?
if [ $ret -ne 0 ];then
        echo "[ERROR4] sync data to slave error ! stopping. "
        exit 1 ;
fi
rm -rf ./hadoop.tar.gz
ssh slave "rm -rf ./hadoop.tar.gz"

#source /home/hadoop/.bashrc
source ./nchc_vagrant/hadoop_conf/bashrc

hadoop namenode -format

start-all.sh


ret=$?
if [ $ret -ne 0 ];then
        echo "[ERROR5] failed to start hadoop "
        exit 1 ;
else 

	echo "[Finished] all things are ready."
	echo "check namenode http://192.168.33.10:50070/"
	echo "check yarn http://192.168.33.10:8088/"
fi

