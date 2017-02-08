 
FROM ubuntu

RUN apt-get update \
 && apt-get install -y \
                       libevent-dev \
                       zlib1g \
                       zlib1g-dev \
                       libpcre3-dev \

ADD "/tmp/tor" "/usr/bin/."

