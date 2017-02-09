FROM ubuntu

RUN apt-get update \
 && apt-get install -y \
                    autoconf \
                    automake \
                    build-essential \
                    ca-certificates \
                    gcc \
                    git \
                    make \
                    libevent-dev \
                    libpcre3-dev \
                    wget \
                    zlib1g \
                    zlib1g-dev \
 && apt-get clean \
 && rm -r /var/lib/apt/lists/*


ENV OPENSSL_VERSION 1.0.2k
ENV OPENSSL_SHA     6b3977c61f2aedf0f96367dcfb5c6e578cf37e7b8d913b4ecb6643c3cb88d8c0
ENV OPENSSL_PREFIX  /data/openssl-${OPENSSL_VERSION}/local

RUN mkdir /data \
 && cd /data \
 && wget http://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz \
 && CHECKSUM=`sha256sum openssl-${OPENSSL_VERSION}.tar.gz | awk '{print $1}'` \
 && test X"${CHECKSUM}" = X${OPENSSL_SHA} \
 && tar xzmf openssl-${OPENSSL_VERSION}.tar.gz \
 && rm openssl-${OPENSSL_VERSION}.tar.gz \
 && cd openssl-${OPENSSL_VERSION} \
 && ./config --shared --prefix=${OPENSSL_PREFIX} \
 && make \
 && make install



# Install tor
# http://tor.stackexchange.com/questions/75/how-can-i-install-tor-from-the-source-code-in-the-git-repository

ENV TOR_BRANCH release-0.2.9

# WARNING: SSL verification does not work!!! Hence GIT_SSL_NO_VERIFY=1
#
# http://stackoverflow.com/questions/21181231/server-certificate-verification-failed-cafile-etc-ssl-certs-ca-certificates-c
# http://stackoverflow.com/questions/7814423/ssl-works-with-browser-wget-and-curl-but-fails-with-git
#
# Even regenerating ca-certs does not help:
# $ update-ca-certificates -f

RUN echo -n \
  | openssl s_client -showcerts -connect git.torproject.org:443 2>/dev/null  \
  | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p'


RUN cd /data \
 && GIT_SSL_NO_VERIFY=1 git clone -b ${TOR_BRANCH} https://git.torproject.org/tor.git \
 && cd tor \
 && sh autogen.sh \
 && ./configure --prefix=/opt/tor-local --with-openssl-dir=${OPENSSL_PREFIX} --disable-asciidoc \
 && make \
 && make install \
 && cd /data \
 && rm -rf tor \
 && ln -s /opt/tor-local/bin/tor /usr/local/bin

RUN chmod 777 /data
ENV HOME /data

WORKDIR "/data"

