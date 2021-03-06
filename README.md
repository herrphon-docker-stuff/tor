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
```


## Links

* <https://www.torproject.org/docs/tor-doc-relay.html.en>
* <https://www.torproject.org/docs/tor-hidden-service.html.en>
* <https://www.torproject.org/docs/faq.html.en#torrc>

