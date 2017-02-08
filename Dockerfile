FROM ubuntu

RUN echo "deb http://deb.torproject.org/torproject.org xenial main" >> /etc/apt/sources.list  \
 && echo "deb-src http://deb.torproject.org/torproject.org xenial main" >> /etc/apt/sources.list \
 && gpg --keyserver keys.gnupg.net --recv A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 \
 && gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | apt-key add - \
 && apt-get update \
 && apt-get install -y tor deb.torproject.org-keyring \
 && apt-get clean \
 && rm -r /var/lib/apt/lists/*

RUN mkdir /data \
 && chmod 777 /data

ENV HOME /data

WORKDIR "/data"

