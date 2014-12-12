#Usage:
#./runtopology.sh - runs in regular mode: run topology on cluster without cleanup
#./runtopology.sh runLocally clean - runs topology locally after cleaning up HDFS/Hivea

#Possible values are "runLocally" to run topology locally or "runOnCluster" anything else to run on cluster
STORMMODE=$1
if [ "$STORMMODE" == "" ]
then
        STORMMODE="runLocally"
fi

#Possible value are "clean" to clean Hive tables and HDFS or "skipclean" to skip cleaning
HDFSMODE=$2

if [ "$HDFSMODE" == "" ]
then
        HDFSMODE="skipclean"
fi



#echo "Killing kafka-hdfs-topology...."
#storm kill kafka-hdfs-topology

#echo "Sleeping for 20 sec..."
#sleep 20

echo "Removing jar..."
cd /root/twitterdemo/storm-kafka-hdfs
rm kafka-hdfs-topology.jar
rm -rf ./classes/*

echo "Compiling kafka-hdfs-topology.jar ..."
#javac -classpath /usr/lib/storm/lib/'*':/usr/lib/storm/contrib/storm-kafka/'*' -d classes *.java
javac -classpath /usr/lib/storm/lib/'*':/usr/lib/storm/contrib/storm-kafka/'*':/usr/lib/storm/contrib/storm-hdfs/'*':/usr/lib/hive/lib/'*':/usr/lib/hadoop/'*' -d classes *.java
jar -cvf kafka-hdfs-topology.jar -C classes/ .

if [ "$HDFSMODE" == "clean" ] 
then
	echo "Cleaning /tmp/stormoutput.txt"
	rm -f /tmp/stormoutput.txt
	echo "Dropping hive table"
	hive -f twitter.sql
	echo "Emptying staging dir in HDFS"
	hadoop fs -rm -R /tweets
fi

echo "Starting toplogy ..."
#/usr/lib/storm/bin/storm  jar kafka-hdfs-topology.jar hellostorm.GNstorm -cp /usr/lib/storm/lib/'*':/usr/lib/storm/contrib/storm-kafka/'*'

java -client -Dstorm.options= -Dstorm.home=/usr/lib/storm -Dstorm.log.dir=/usr/lib/storm/logs -Djava.library.path=/usr/local/lib:/opt/local/lib:/usr/lib -Dstorm.conf.file= -cp /usr/lib/storm/lib/kryo-2.17.jar:/usr/lib/storm/lib/logback-classic-1.0.6.jar:/usr/lib/storm/lib/slf4j-api-1.6.5.jar:/usr/lib/storm/lib/commons-exec-1.1.jar:/usr/lib/storm/lib/clj-stacktrace-0.2.4.jar:/usr/lib/storm/lib/httpclient-4.1.1.jar:/usr/lib/storm/lib/joda-time-2.0.jar:/usr/lib/storm/lib/commons-codec-1.4.jar:/usr/lib/storm/lib/jetty-util-6.1.26.jar:/usr/lib/storm/lib/servlet-api-2.5.jar:/usr/lib/storm/lib/jline-2.11.jar:/usr/lib/storm/lib/carbonite-1.3.2.jar:/usr/lib/storm/lib/reflectasm-1.07-shaded.jar:/usr/lib/storm/lib/curator-client-1.3.3.jar:/usr/lib/storm/lib/clj-time-0.4.1.jar:/usr/lib/storm/lib/ring-servlet-0.3.11.jar:/usr/lib/storm/lib/jgrapht-core-0.9.0.jar:/usr/lib/storm/lib/disruptor-2.10.1.jar:/usr/lib/storm/lib/jetty-6.1.26.jar:/usr/lib/storm/lib/ring-core-1.1.5.jar:/usr/lib/storm/lib/guava-13.0.jar:/usr/lib/storm/lib/ring-devel-0.3.11.jar:/usr/lib/storm/lib/logback-core-1.0.6.jar:/usr/lib/storm/lib/commons-io-2.4.jar:/usr/lib/storm/lib/meat-locker-0.3.1.jar:/usr/lib/storm/lib/tools.cli-0.2.2.jar:/usr/lib/storm/lib/clojure-1.4.0.jar:/usr/lib/storm/lib/asm-4.0.jar:/usr/lib/storm/lib/netty-3.6.3.Final.jar:/usr/lib/storm/lib/tools.macro-0.1.0.jar:/usr/lib/storm/lib/math.numeric-tower-0.0.1.jar:/usr/lib/storm/lib/curator-framework-1.3.3.jar:/usr/lib/storm/lib/compojure-1.1.3.jar:/usr/lib/storm/lib/ring-jetty-adapter-0.3.11.jar:/usr/lib/storm/lib/storm-core-0.9.1.2.1.1.0-385.jar:/usr/lib/storm/lib/snakeyaml-1.11.jar:/usr/lib/storm/lib/clout-1.0.1.jar:/usr/lib/storm/lib/httpcore-4.1.jar:/usr/lib/storm/lib/commons-lang-2.5.jar:/usr/lib/storm/lib/hiccup-0.3.6.jar:/usr/lib/storm/lib/zookeeper.jar:/usr/lib/storm/lib/commons-fileupload-1.2.1.jar:/usr/lib/storm/lib/minlog-1.2.jar:/usr/lib/storm/lib/tools.logging-0.2.3.jar:/usr/lib/storm/lib/log4j-over-slf4j-1.6.6.jar:/usr/lib/storm/lib/servlet-api-2.5-20081211.jar:/usr/lib/storm/lib/netty-3.2.2.Final.jar:/usr/lib/storm/lib/json-simple-1.1.jar:/usr/lib/storm/lib/core.incubator-0.1.0.jar:/usr/lib/storm/lib/commons-logging-1.1.1.jar:/usr/lib/storm/lib/objenesis-1.2.jar:kafka-hdfs-topology.jar:/usr/lib/storm/conf:/usr/lib/storm/bin:/usr/lib/storm/lib/*:/usr/lib/storm/contrib/storm-kafka/*:/usr/lib/storm/contrib/storm-kafka-example/*:/usr/lib/storm/contrib/storm-hdfs/*:/usr/lib/hive/lib/*:/usr/lib/hadoop/*:/usr/lib/hadoop-hdfs/*:/usr/lib/hadoop/lib/commons-configuration-1.6.jar -Dstorm.jar=kafka-hdfs-topology.jar hellostorm.GNstorm $STORMMODE 

#echo "Done! Bolt output will be written to /tmp/stormoutput.txt. You can run 'tail -F /tmp/stormoutput.txt' command to watch processed items"
#echo "Logs under /var/log/storm and Storm WebUI available at http://<VM IP address>:8744"
#echo "To kill the topology, use the command: storm kill kafka-hdfs-topology"
