
echo "Compiling jar..."
cd /root/twitterdemo/fetchSecuritiesList
rm -f fetchsecurities.jar
rm -rf classes/*
javac  -d classes *.java
jar -cvf fetchsecurities.jar -C classes/ .
export CLASSPATH=fetchsecurities.jar
java example.producer.FetchSecuritiesList

