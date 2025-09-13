FROM hashicorp/terraform:latest

RUN apk add --update \
    python3 \
    curl \
    which \
    jq \
    bash

RUN curl -sSL https://sdk.cloud.google.com | bash

ENV PATH $PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/root/google-cloud-sdk/bin

RUN gcloud components install beta

ENTRYPOINT [ "/usr/bin/env" ]
