mkdir /opt/kafka
cd /opt/kafka
wget http://mirror.cogentco.com/pub/apache/kafka/0.8.1.1/kafka_2.8.0-0.8.1.1.tgz
tar xvzf kafka_2.8.0-0.8.1.1.tgz
ln -s kafka_2.8.0-0.8.1.1/ latest
cd latest

if [ `ps -ef |  grep kafka.Kafk[a] | wc -l` -gt 0 ]
then
        echo "Detected Kafka is already running"
else
        echo "Kafka is down...restarting"
        nohup /opt/kafka/latest/bin/kafka-server-start.sh /opt/kafka/latest/config/server.properties &
        sleep 5
fi

echo "Creating twitter_events topic"
/opt/kafka/latest/bin/kafka-topics.sh --create --zookeeper sandbox.hortonworks.com:2181 --replication-factor 1 --partitions 1 --topic twitter_events
/opt/kafka/latest/bin/kafka-topics.sh --zookeeper sandbox.hortonworks.com:2181 --list

