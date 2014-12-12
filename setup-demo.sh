set -e 
rpmdb --rebuilddb
/root/start_ambari.sh
echo "Starting HBase..."
/root/start_hbase.sh
echo "Installing mvn..."
/root/twitterdemo/setup-scripts/install_mvn.sh > /root/twitterdemo/logs/install_mvn.log
echo "Installing Kafka..."
/root/twitterdemo/setup-scripts/install_kafka.sh > /root/twitterdemo/logs/install_kafka.log
echo "Installing Solr..."
/root/twitterdemo/setup-scripts/install_solr.sh > /root/twitterdemo/logs/install_solr.log
echo "Installing Banana..."
/root/twitterdemo/setup-scripts/install_banana.sh > /root/twitterdemo/logs/install_banana.log
echo "Installing Phoenix"
/root/twitterdemo/setup-scripts/install_phoenix.sh > /root/twitterdemo/logs/install_phoenix.log

echo "Setup complete. Logs available under /root/twitterdemo/logs"


