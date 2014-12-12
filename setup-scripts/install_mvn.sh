#!/bin/bash

mkdir /usr/share/maven
cd /usr/share/maven
wget http://www.carfab.com/apachesoftware/maven/maven-3/3.2.2/binaries/apache-maven-3.2.2-bin.tar.gz
tar xvzf apache-maven-3.2.2-bin.tar.gz
ln -s /usr/share/maven/apache-maven-3.2.2/ /usr/share/maven/latest
echo 'M2_HOME=/usr/share/maven/latest' >> ~/.bashrc
echo 'M2=$M2_HOME/bin' >> ~/.bashrc
echo 'PATH=$PATH:$M2' >> ~/.bashrc
source ~/.bashrc

