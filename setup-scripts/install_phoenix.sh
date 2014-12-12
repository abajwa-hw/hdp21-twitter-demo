#install phoenix (only needed one time)
cd
wget http://mirror.olnevhost.net/pub/apache/phoenix/phoenix-4.1.0/bin/phoenix-4.1.0-bin.tar.gz
tar -zxvf phoenix-4.1.0-bin.tar.gz
cp phoenix-4.1.0-bin/hadoop2/phoenix-4.1.0-server-hadoop2.jar /usr/lib/hbase/lib/
chmod 644 /usr/lib/hbase/lib/phoenix-4.1.0-server-hadoop2.jar
ln -s /usr/lib/hbase/lib/phoenix-4.1.0-server-hadoop2.jar /usr/lib/hbase/lib/phoenix.jar
chmod ugo+rx /root
chmod ugo+rx /root/phoenix-4.1.0-bin
chmod ugo+rx /root/phoenix-4.1.0-bin/hadoop2
chmod ugo+r /root/phoenix-4.1.0-bin/hadoop2/*
chown -R root:root /root/phoenix-4.1.0-bin
rm /root/phoenix-4.1.0-bin.tar.gz
