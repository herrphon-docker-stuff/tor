
# Getting started

```bash
mkdir hidden-service
chmod 700 hidden-service
export UID=$UID

docker-compose up
```


Either copy torrc.sample to torrc and configure, or use the following:
``` bash
SocksPort 9050 # Default: Bind to localhost:9050 for local connections.

# HiddenServiceDir should be chmod 700:
HiddenServiceDir /data/hidden-service

HiddenServicePort 22 127.0.0.1:22
HiddenServicePort 80 web:80

ExitPolicy reject *:* # no exits allowed


## Details & Version

Installation from package with version:

```
Tor 0.2.9.9 (git-1d8323c042800718) running on Linux with Libevent 2.0.21-stable, OpenSSL 1.0.2g and Zlib 1.2.8.
```


## Details and Version

Instaleld from official package with version:

```
Tor 0.2.9.9 (git-1d8323c042800718) running on Linux with Libevent 2.0.21-stable, OpenSSL 1.0.2g and Zlib 1.2.8.
```


## Links

* <https://www.torproject.org/docs/tor-doc-relay.html.en>
