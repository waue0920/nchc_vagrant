#!/bin/bash

if [ $(whoami) != "hadoop" ];then
        echo "Please Use 'hadoop' to login, .. action skip! ";
        exit 1;
fi


#echo "1. download the hadoop scripts ";
#git clone https://github.com/waue0920/nchc_vagrant.git
#ret=$?
#if [ $ret -ne 0 ];then
#        echo "[error] 1. git clone error !!! "
#        exit 1 ;
#fi


echo "1. copy hadoop settings ";
cp -f nchc_vagrant/hadoop_conf/*.xml /home/hadoop/hadoop/etc/hadoop/
cp -f nchc_vagrant/hadoop_conf/hadoop-env.sh /home/hadoop/hadoop/etc/hadoop/
cp -f nchc_vagrant/hadoop_conf/slaves /home/hadoop/hadoop/etc/hadoop/
ret=$?
if [ $ret -ne 0 ];then
        echo "[error] 1 copy hadoop files error !!! "
        exit 1 ;
else
        echo "check ... [OK] "
fi



echo "2. copy env files settings ";
cp -f nchc_vagrant/hadoop_conf/hadoop-config.sh /home/hadoop/hadoop/libexec/

cp -f nchc_vagrant/hadoop_conf/bashrc /home/hadoop/.bashrc
ret=$?
if [ $ret -ne 0 ];then
        echo "[error] 2 copy env files error !!! "
        exit 1 ;
else
        echo "check ... [OK] "
fi


