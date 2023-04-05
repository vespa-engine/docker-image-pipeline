# Copyright Yahoo. Licensed under the terms of the Apache 2.0 license. See LICENSE in the project root
FROM docker.io/almalinux:9

# Java requires proper locale for unicode
ENV LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8

RUN dnf module enable -y maven:3.8 && \
    dnf install -y \
      buildah \
      dnf-plugins-core \
      epel-release \
      git-core \
      glibc-langpack-en \
      java-17-openjdk-devel \
      maven-openjdk17 \
      openssh-clients \
      podman \
      podman-docker \
      skopeo \
      which && \
    sed -i 's,.*netns.*=.*private.*,netns = "host",' /usr/share/containers/containers.conf && \
    touch /etc/containers/nodocker && \
    dnf config-manager --enable \
      crb \
      epel && \
    dnf clean all

# Install vespa-cli
RUN VESPA_CLI_VERSION=$(curl -fsSL https://api.github.com/repos/vespa-engine/vespa/releases/latest | grep -Po '"tag_name": "v\K.*?(?=")') && \
    curl -fsSL https://github.com/vespa-engine/vespa/releases/download/v${VESPA_CLI_VERSION}/vespa-cli_${VESPA_CLI_VERSION}_linux_amd64.tar.gz | tar -zxf - -C /opt && \
    ln -sf /opt/vespa-cli_${VESPA_CLI_VERSION}_linux_amd64/bin/vespa /usr/local/bin/
