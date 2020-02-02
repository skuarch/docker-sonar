#!/bin/bash 

echo "running sonar"

JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

cd /opt/sonarqube-6.7.6/bin
rm -r /opt/sonarqube-6.7.6/temp
/opt/sonarqube-6.7.6/bin/linux-x86-64/sonar.sh start
tail -100f /opt/sonarqube-6.7.6/logs/sonar.log