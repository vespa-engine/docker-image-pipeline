# Copyright 2019 Oath Inc. Licensed under the terms of the Apache 2.0 license. See LICENSE in the project root
FROM centos:7

RUN yum install -y epel-release && \
    yum install -y centos-release-scl && \
    yum install -y git openssh-clients rh-maven35 java-11-openjdk-devel java-1.8.0-openjdk-devel

RUN echo "export JAVA_11=$(alternatives --display java | grep 'family java-11-openjdk' | cut -d' ' -f1)" >> /etc/profile.d/jdk-env.sh && \
    echo "export JAVAC_11=$(alternatives --display javac | grep 'family java-11-openjdk' | cut -d' ' -f1)" >> /etc/profile.d/jdk-env.sh && \
    echo "export JAVA_11_HOME=/usr/lib/jvm/java-11-openjdk" >> /etc/profile.d/jdk-env.sh && \
    echo "export JAVA_8=$(alternatives --display java | grep 'family java-1.8.0-openjdk' | cut -d' ' -f1)" >> /etc/profile.d/jdk-env.sh && \
    echo "export JAVAC_8=$(alternatives --display javac | grep 'family java-1.8.0-openjdk' | cut -d' ' -f1)" >> /etc/profile.d/jdk-env.sh && \
    echo "export JAVA_8_HOME=/usr/lib/jvm/java-1.8.0-openjdk" >> /etc/profile.d/jdk-env.sh

# Java requires proper locale for unicode
ENV LANG en_US.UTF-8

# Maven 3.5 required
ENV PATH="/opt/rh/rh-maven35/root/usr/bin:${PATH}"

