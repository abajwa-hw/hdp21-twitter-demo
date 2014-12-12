
echo "Compiling jar..."
cd /root/hdp21-twitter-demo/fetchSecuritiesList
rm -f fetchsecurities.jar
rm -rf classes/*
javac  -d classes *.java
jar -cvf fetchsecurities.jar -C classes/ .
export CLASSPATH=fetchsecurities.jar
java example.producer.FetchSecuritiesList

