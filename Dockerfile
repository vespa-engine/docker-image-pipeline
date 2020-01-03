# Copyright 2019 Oath Inc. Licensed under the terms of the Apache 2.0 license. See LICENSE in the project root
FROM centos:7

# Java requires proper locale for unicode
ENV LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8

RUN yum install -y epel-release && \
    yum install -y centos-release-scl && \
    yum install -y which git openssh-clients java-11-openjdk-devel && \
    yum clean all --enablerepo='*'

RUN echo "export JAVA_HOME=/usr/lib/jvm/java-11-openjdk" >> /etc/profile.d/jdk-env.sh

# Maven 3.6 required
RUN curl -sLf -o - "http://apache.uib.no/maven/maven-3/3.6.1/binaries/apache-maven-3.6.1-bin.tar.gz" | tar -C /usr/lib -zxf -
ENV M2_HOME="/usr/lib/apache-maven-3.6.1"
ENV PATH="${M2_HOME}/bin:${PATH}"

