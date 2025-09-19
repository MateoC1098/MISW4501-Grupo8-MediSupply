FROM python:3.11.4-bookworm

# DEBIAN_FRONTEND=noninteractive is to avoid tzdata prompt
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update \
    && apt-get install -y --no-install-recommends curl=7.88.1-10+deb12u5 \
    && rm -rf /var/lib/apt/lists/*

ENV NVM_DIR  /usr/local/nvm
ENV NODE_VERSION 20.10.0

RUN mkdir $NVM_DIR \
    && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

ENV NODE_PATH $NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH
RUN npm install -g prettier@3.1.1

# Add a non-root user to run the scripts
# -m is to create the home directory
# -s is to set the default shell
RUN useradd -ms /bin/bash devops
USER devops
WORKDIR /home/devops

# This is to avoid Python to buffer the outputs
ENV PYTHONUNBUFFERED True
ENV PYTHONIOENCODING utf-8

COPY Pipfile Pipfile.lock ./

RUN pip install pipenv==2023.11.15 --no-cache-dir
ENV PATH    /home/devops/.local/bin:$PATH
RUN pipenv requirements > requirements.txt && pip install -r requirements.txt --no-cache-dir

# HEALTHCHECK --interval=5m --timeout=3s \
#     CMD curl -f http://localhost/ || exit 1

CMD ["bash"]
