FROM openjdk:alpine

WORKDIR /tmp

ENV S6_OVERLAY_VERSION=v1.18.1.4
ENV TERM=xterm

RUN apk update && \ 
    apk add --no-cache bash libstdc++ git curl && \
    curl -sSL https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_VERSION}/s6-overlay-amd64.tar.gz | tar xfz - -C / && \ 
    mkdir /dist && \
    mkdir /etc/jonglisto && \
    mkdir /var/cache/jonglisto-db && \
#   mkdir /dist/logos && \
#   git clone https://github.com/FrodoVDR/channellogos.git && \
#   cp -r /tmp/channellogos/logos-orig/* /dist/logos && \
	git clone https://github.com/3PO/Senderlogos.git /dist/logos && \
	rm -rf /var/cache/apk/*
       
RUN git clone https://github.com/Zabrimus/vdr-jonglisto.git && \
    cd /tmp/vdr-jonglisto && \
    ./gradlew standaloneWar && \
    cp /tmp/vdr-jonglisto/build/libs/vdr-jonglisto-0.0.1.war /dist && \
    cd /tmp/ && \    
    rm -Rf /root/.gradle/ && \
    rm -Rf /tmp/*

COPY jonglisto.sh /etc/services.d/jonglisto/run
COPY jonglisto.json /etc/jonglisto/jonglisto.json


ENTRYPOINT ["/init"]
CMD []

EXPOSE 8080
