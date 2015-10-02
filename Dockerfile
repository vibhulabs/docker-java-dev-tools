# Ubuntu 14.04 LTS
# Oracle Java 1.8.0_60 64 bit
# Maven 3.3.3
# Jenkins 1.631
# git 1.9.1
#
# Based on the work done by Stephen L. Reed (http://texai.org, stephenreed@yahoo.com)
#   https://hub.docker.com/r/stephenreed/jenkins-java8-maven-git

# extend the most recent JDK on Ubuntu image
FROM vibhulabs/java:latest

MAINTAINER Vibhu Labs

# this is a non-interactive automated build - avoid some warning messages
ENV DEBIAN_FRONTEND noninteractive

# update dpkg repositories
RUN apt-get update 

# get maven 3.3.3
RUN wget --no-verbose -O \
	/tmp/apache-maven-3.3.3.tar.gz \ 
	http://archive.apache.org/dist/maven/maven-3/3.3.3/binaries/apache-maven-3.3.3-bin.tar.gz

# verify checksum
RUN echo "794b3b7961200c542a7292682d21ba36 /tmp/apache-maven-3.3.3.tar.gz" | md5sum -c

# install maven
RUN tar xzf /tmp/apache-maven-3.3.3.tar.gz -C /opt/
RUN ln -s /opt/apache-maven-3.3.3 /opt/maven
RUN ln -s /opt/maven/bin/mvn /usr/local/bin
RUN rm -f /tmp/apache-maven-3.3.3.tar.gz
ENV MAVEN_HOME /opt/maven

# install unzip
RUN apt-get install -y unzip

# get gradle
RUN wget --no-verbose -O \ 
	/tmp/gradle-2.7-bin.zip \
	https://services.gradle.org/distributions/gradle-2.7-bin.zip

# verify checksum
RUN echo "fe801ce2166e6c5b48b3e7ba81277c41 /tmp/gradle-2.7-bin.zip" | md5sum -c

# install gradle
RUN unzip /tmp/gradle-2.7-bin.zip -d /opt/
RUN ln -s /opt/gradle-2.7-bin.zip /opt/gradle
RUN ln -s /opt/gradle/bin/gradle /usr/local/bin
RUN rm -f /tmp/gradle-2.7-bin.zip
ENV GRADLE_HOME /opt/gradle

# install git
RUN apt-get install -y git

# remove download archive files
RUN apt-get clean

CMD [""]

