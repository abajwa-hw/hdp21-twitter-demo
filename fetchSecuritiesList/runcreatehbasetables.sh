echo "Creating Hbase table with thresholds"
/root/phoenix-4.1.0-bin/hadoop2/bin/psql.py  localhost:2181:/hbase /root/twitterdemo/fetchSecuritiesList/hbase-createstockthresholds.sql /root/twitterdemo/fetchSecuritiesList/securities.csv

