# ! Here are the steps made from the video

scp -i Reto3.pem hadoop@ec2-34-229-205-77.compute-1.amazonaws.com:/etc/hadoop/conf/core-site.xml ~/GitHub/Youngermaster/Reto-5-ST0263
scp -i Reto3.pem ~/GitHub/Youngermaster/Reto-5-ST0263/core-site.xml hadoop@ec2-34-229-205-77.compute-1.amazonaws.com:/etc/hadoop/conf/core-site.xml

sudo hdfs --daemon start httpfs
sudo -u hdfs hadoop fs -mkdir -p /user/admin

sudo -u hdfs hadoop fs -mkdir /user/test
sudo -u hdfs hadoop fs -chown hadoop:hadoop /user/test
echo "Hello, EMR" | hadoop fs -put - /user/test/hello_emr.txt
hadoop fs -ls /user/test
hadoop distcp /user/test/hello_emr.txt s3://jmyoungh-lab-emr/test/hello_emr.txt
hadoop dstcp s3://jmyoungh-lab-emr/test/HIM.jpeg /user/test/HIM.jpeg
hadoop fs -ls /user/test