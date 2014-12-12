mkdir /opt/banana
chown solr:solr /opt/banana
cd /opt/banana
wget  https://github.com/LucidWorks/banana/archive/banana-1.4.tar.gz
tar xzf banana-1.4.tar.gz
ln -s banana-banana-1.4 latest
rm -rf banana-*.gz
sed -i 's/localhost/sandbox.hortonworks.com/g' /opt/banana/latest/src/config.js
sed -i 's/logstash_logs/tweets/g' /opt/banana/latest/src/config.js
cd /opt/banana/latest/src/app/dashboards
cp ~/hdp21-twitter-demo/default.json /opt/banana/banana-banana-1.4/src/app/dashboards/default.json

#build banana webapp
cd /opt/banana/latest
mkdir build
yum -y install ant
ant
cp -f /opt/banana/latest/build/banana*.war /opt/solr/latest/hdp/webapps/banana.war
cp -f /opt/banana/latest/jetty-contexts/banana-context.xml /opt/solr/latest/hdp/contexts/

#start solr
echo "Starting Solr..."
nohup java -jar /opt/solr/latest/hdp/start.jar -Djetty.home=/opt/solr/latest/hdp -Dsolr.solr.home=/opt/solr/latest/hdp/solr &> /root/hdp21-twitter-demo/logs/solr.out &
echo "Waiting for Solr to start..."
sleep 10
curl "http://localhost:8983/solr/admin/cores?action=CREATE&name=tweets&instanceDir=/opt/solr/latest/hdp/solr/tweets"

