FROM ubuntu:18.04

MAINTAINER Alfredo Bello <jose.bello@astrazeneca.com>

ADD ./sonar.properties ./startup.sh /tmp/

ENV proxy_ip='165.225.34.41'
ENV proxy_port=10263
ENV http_proxy 'http://'$proxy_ip':'$proxy_port
ENV https_proxy 'http://'$proxy_ip':'$proxy_port
ENV proxy $proxy_ip
ENV sonar_name 'sonarqube-'
ENV sonar_version '6.7.6'
ENV sonar_extention '.zip'
ENV JAVA_HOME='/usr/lib/jvm/java-8-openjdk-amd64'
ENV download='https://binaries.sonarsource.com/Distribution/sonarqube/'$sonar_name$sonar_version$sonar_extention

RUN groupadd -r sonarqube && useradd -r -g sonarqube sonarqube

RUN apt-get update -y && \
apt-get install unzip curl openjdk-8-jdk -y -f && \
su sonarqube && \
sonar=$sonar_name$sonar_version$sonar_extention && \
echo $download && \
curl -O -L -k --proxy-insecure "$download" && \
unzip /$sonar && \
mv /$sonar_name$sonar_version /opt/ && \
rm -r /opt/$sonar_name$sonar_version/temp && \
chown -R sonarqube:sonarqube /opt/$sonar_name$sonar_version && \
rm /opt/$sonar_name$sonar_version/conf/sonar.properties && \
mv /tmp/sonar.properties /opt/$sonar_name$sonar_version/conf && \
chmod 777 -R /opt/$sonar_name$sonar_version && \
chown -R sonarqube:sonarqube /opt/$sonar_name$sonar_version && \
mv /tmp/startup.sh / && \
chmod +x /startup.sh && \
rm -rf /tmp/* && \
rm -rf /$sonar && \ 
apt-get remove curl -y && \
apt-get remove unzip -y 


EXPOSE 9000
VOLUME /opt/$sonar_name$sonar_version
USER sonarqube
CMD /startup.sh
