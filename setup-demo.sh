set -e 
rpmdb --rebuilddb
/root/start_ambari.sh
echo "Starting HBase..."
/root/start_hbase.sh
echo "Installing mvn..."
/root/hdp21-twitter-demo/setup-scripts/install_mvn.sh > /root/hdp21-twitter-demo/logs/install_mvn.log
echo "Installing Kafka..."
/root/hdp21-twitter-demo/setup-scripts/install_kafka.sh > /root/hdp21-twitter-demo/logs/install_kafka.log
echo "Installing Solr..."
/root/hdp21-twitter-demo/setup-scripts/install_solr.sh > /root/hdp21-twitter-demo/logs/install_solr.log
echo "Installing Banana..."
/root/hdp21-twitter-demo/setup-scripts/install_banana.sh > /root/hdp21-twitter-demo/logs/install_banana.log
echo "Installing Phoenix"
/root/hdp21-twitter-demo/setup-scripts/install_phoenix.sh > /root/hdp21-twitter-demo/logs/install_phoenix.log

echo "Setup complete. Logs available under /root/hdp21-twitter-demo/logs"


