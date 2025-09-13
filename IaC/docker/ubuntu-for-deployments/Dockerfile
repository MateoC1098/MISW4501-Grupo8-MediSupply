# This image just add extra dependencies required for the deployments to run
# Reference: https://octopus.com/blog/using-ubuntu-docker-image
FROM ubuntu:24.04

# DEBIAN_FRONTEND=noninteractive is to avoid tzdata prompt
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update \
    && apt-get -y install \
    curl \
    gpg \
    openssh-client \
    wget \
    && rm -rf /var/lib/apt/lists/*

RUN wget https://apt.puppet.com/puppet8-release-noble.deb
RUN apt-get -y --fix-missing --fix-broken install ./puppet8-release-noble.deb
RUN rm -f ./puppet8-release-noble.deb

RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
    && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg

RUN apt-get update && apt-get -y --fix-missing --fix-broken install google-cloud-sdk puppet

ENV NVM_DIR  /usr/local/nvm
ENV NODE_VERSION 22

RUN mkdir $NVM_DIR \
    && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

ENV NODE_PATH $NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

# Install dependencies (Chrome - develop for the web)
RUN curl -O https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
    && apt-get -y --fix-missing --fix-broken install ./google-chrome-stable_current_amd64.deb \
    && rm -rf /var/lib/apt/lists/*

# Add a non-root user to run the deployments
# -m is to create the home directory
# -s is to set the default shell
RUN useradd -ms /bin/bash devops
USER devops
WORKDIR /home/devops

ENV SSH_KNOWN_HOST_GATEWAY 35.231.39.19

ARG PORT
ENV SSH_PORT=${PORT:-22}

RUN mkdir -p .ssh && chmod 700 .ssh
RUN ssh-keyscan -Hv ${SSH_KNOWN_HOST_GATEWAY} > .ssh/known_hosts \
    && chmod 644 .ssh/known_hosts
