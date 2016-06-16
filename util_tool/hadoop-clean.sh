#!/bin/bash
ret=$(whoami)
if [ $ret != "hadoop" ];then
        echo "[ERROR0] please login as hadoop "
        echo "> sudo su - hadoop  "
        exit 1 ;
fi


cd ~

killall java
ssh slave "killall java"



ssh slave "rm -rf ~/.ssh; rm -rf ./hadoop ; rm -rf ./hadoop_dir"
ret=$?
if [ $ret -ne 0 ];then
        echo "[ERROR1] failed to delete remote hadoop "
        exit 1 ;
fi

rm -rf .ssh ./hadoop ./hadoop_dir ./nchc_vagrant
ret=$?
if [ $ret -ne 0 ];then
        echo "[ERROR2] failed to delete local hadoop "
        exit 1 ;
else
        echo "[Finished] all things on hadoop are clean."
fi
