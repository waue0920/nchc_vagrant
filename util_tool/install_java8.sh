

if [ -d "/opt/maven" ]; then
        echo "Maven already installed in /opt/maven, skipping!"
        exit 0
fi



sudo apt-get --yes update 
sudo apt-get --yes install build-essential rsync telnet screen man wget 
sudo apt-get --yes install strace tcpdump 
sudo apt-get --yes install libssl-dev zlib1g-dev libcurl3-dev libxslt-dev 
sudo apt-get --yes install software-properties-common python-software-properties 
sudo apt-get --yes install git 
sudo add-apt --yes-repository ppa:webupd8team/java 
sudo apt-get --yes install oracle-java8-installer 
sudo apt-get --yes install ant 





LATEST="3.2.5"

if (( "$#" == 1 )); then
        LATEST=$1
fi

FILENAME="apache-maven-$LATEST-bin.tar.gz"
LINK="http://ftp.unicamp.br/pub/apache/maven/maven-3/$LATEST/binaries/$FILENAME"

echo "$LINK"

wget --no-check-certificate "$LINK"

mkdir maven
tar -zxvf $FILENAME -C maven --strip-components 1

# Will copy to /opt
sudo mv maven /opt/

# set PATH env variable
grep '/opt/maven/bin' /etc/profile || echo 'PATH=$PATH:/opt/maven/bin' >> /etc/profile

# Cleanup
rm -f $FILENAME
rm -f equip_maven3.sh

echo "Installed in /opt/maven"



