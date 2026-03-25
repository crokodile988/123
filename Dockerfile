FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

SHELL ["/bin/bash", "-c"]

RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Устанавливаем V2Ray — скачиваем скрипт явно, чтобы избежать проблем с /bin/sh
RUN curl -L https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-release.sh -o /tmp/install-v2ray.sh \
    && bash /tmp/install-v2ray.sh \
    && rm /tmp/install-v2ray.sh

COPY config.json /usr/local/etc/v2ray/config.json
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 8080

CMD ["/start.sh"]
