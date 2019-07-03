FROM ubuntu:disco

ARG EMBY_VERSION

COPY docker-entrypoint.sh /docker-entrypoint.sh

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        wget \
        # ffmpeg \
        # libavdevice58 \
        va-driver-all \
        pciutils \
        dumb-init && \
    wget --no-check-certificate https://github.com/MediaBrowser/Emby.Releases/releases/download/${EMBY_VERSION}/emby-server-deb_${EMBY_VERSION}_amd64.deb && \
    apt-get install -y ./emby-server-deb_${EMBY_VERSION}_amd64.deb || true && \
    apt-get remove --purge -y wget || true && \
    rm -rf /var/lib/apt/lists/* 

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/docker-entrypoint.sh"]

