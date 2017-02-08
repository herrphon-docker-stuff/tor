FROM ubuntu

RUN apt-get update \
 && apt-get install -y gcc \
                       make \
                       git \
                       autoconf \
                       automake \
                       libevent-dev \
                       zlib1g \
                       zlib1g-dev \
                       libpcre3-dev \
                       wget

# Original from: https://raw.githubusercontent.com/apk/buildery/master/tor-build/build.sh  

ENV opssl 1.0.2k
ENV opsha256 6b3977c61f2aedf0f96367dcfb5c6e578cf37e7b8d913b4ecb6643c3cb88d8c0

RUN mkdir /app \
 && cd /app \
 && wget http://www.openssl.org/source/openssl-$opssl.tar.gz \
 && export sha256=`sha256sum openssl-$opssl.tar.gz | awk '{print $1}'` \
 && test X"$sha256" = X$opsha256 \
 && export PREFIX=`pwd`/local \
 && tar xzf openssl-$opssl.tar.gz \
 && cd openssl-${opssl} \
 && ./config --shared --prefix=$P \
 && make \
 && make install \
 && echo "$opssl" > sslvers 



VOLUME "/outside_tmp"

CMD ["cp", "/app/tor/src/or/tor", "/outside_tmp/."]


#test -d tor || git clone -b release-0.2.9 https://git.torproject.org/tor.git || exit 1
#
#(cd tor && \
#   git clean -fdx && \
#   sh autogen.sh && \
#   ./configure --prefix=$HOME/tor-local --with-openssl-dir=$P --disable-asciidoc && \
#   make
#) || exit 1
#
#exit


