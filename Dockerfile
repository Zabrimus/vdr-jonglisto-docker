FROM openjdk:alpine

WORKDIR /tmp

ENV JONGLISTO_VERSION=0.0.4
ENV S6_OVERLAY_VERSION=v1.18.1.4
ENV TERM=xterm

RUN apk update && \ 
    apk add --no-cache bash curl && \
    mkdir /dist && \
    mkdir /dist/logos && \
    mkdir /etc/jonglisto && \
    mkdir /var/cache/jonglisto-db && \

    curl -sSL https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_VERSION}/s6-overlay-amd64.tar.gz | tar xfz - -C / && \ 
    curl -sSL https://github.com/Zabrimus/vdr-jonglisto/releases/download/${JONGLISTO_VERSION}/vdr-jonglisto-${JONGLISTO_VERSION}.war -o /dist/vdr-jonglisto-${JONGLISTO_VERSION}.war && \

    rm -rf /var/cache/apk/*
       
COPY jonglisto.sh /etc/services.d/jonglisto/run

ENTRYPOINT ["/init"]
CMD []

VOLUME /dist/logos
VOLUME /etc/jonglisto

EXPOSE 8080

