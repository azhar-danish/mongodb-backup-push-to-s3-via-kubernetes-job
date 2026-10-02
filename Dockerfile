FROM mongo:8

RUN apt-get update \
    && apt-get install -y curl unzip \
    && curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" \
       -o "/tmp/awscliv2.zip" \
    && unzip /tmp/awscliv2.zip -d /tmp \
    && /tmp/aws/install \
    && rm -rf /tmp/aws /tmp/awscliv2.zip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY backup.sh /backup.sh

RUN chmod +x /backup.sh

ENTRYPOINT ["/backup.sh"]