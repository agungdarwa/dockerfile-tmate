# Dockerfile Tmate-ssh-server
> Short blurb about what your product does.

[![Build Status][travis-image]][travis-url]
[![Downloads Stats][npm-downloads]][npm-url]

Tmate dockerfile for create docker image with own [tmate-ssh-server](https://github.com/tmate-io/tmate-ssh-server)

You can use your own generate keys. You can only allow connections using the keys entired in the `authorized_keys`  

Details for use this service on [tmate.io](https://tmate.io/)

## Full-featured usage

This example uses a server with all the functions. Connection is availble only for those clients whose public keys are included in the `authorized_keys` (Knowledge of lines: `[hash]@SERVER_FQDN` is not enough for connect)
```sh
docker run --privileged --rm -i -p 22:22 \
     -v /etc/tmate/keys:/daemon-keys \  # server keys for auth server host (mount directory)
     -v /etc/tmate/authorized_keys:/authorized-keys \ # user keys for auth client connections (mount file)
     tmate-ssh-server \  # name of building docker image
     /bin/sh -c "/sbin/tmate-ssh-server -k /daemon-keys -a /authorized-keys -b 0.0.0.0 -p 22 -v -v -v -h SERVER_FQDN"
```

### Variant to allow clients to connect only by line: `[hash]@SERVER_FQDN`
```sh
docker run --privileged --rm -i -p 22:22 \
     -v /etc/tmate/keys:/daemon-keys \  # server keys for auth server host (mount directory)
     tmate-ssh-server \  # name of building docker image
     /bin/sh -c "/sbin/tmate-ssh-server -k /daemon-keys -b 0.0.0.0 -p 22 -v -v -v -h SERVER_FQDN"
```


## Featured of use

You need to deploy the server on a separate port (do not use the same port with ssh). `Tmate-ssh-server` independently implements the ssh protocol, openssh is not used. 

### Server keys

Versions on current year there is a [bug](https://github.com/tmate-io/tmate-ssh-server/issues/54), because of which you need to use only one server key - rsa. You can use host key from /etc/ssh or generate separate key.


## Client tmate config

Typical configuration file for the client `.tmate.conf`.

```sh
set -g tmate-server-host "tmate.d4s.elatica.space"
set -g tmate-server-port 73
set -g tmate-server-rsa-fingerprint "be:6c:bc:4d:02:6b:f7:fe:5c:05:26:5c:c8:94:6d:2b"
```
Fingerprint must be on `md5` format, for get fingerprint use command: `ssh-keygen -E md5 -lf [sshkeyfile]`

If the client key file does not use the default name (default: id_rsa), you must additionally use the option:
```sh
set -g tmate-identity "[path to you ssh key]"
```

## Meta

Maxim Danilin – zan@whiteants.net

Distributed under the MIT license. 


<!-- Markdown link & img dfn's -->
[npm-url]: https://npmjs.org/package/datadog-metrics
[npm-downloads]: https://img.shields.io/npm/dm/datadog-metrics.svg?style=flat-square
[travis-image]: https://img.shields.io/travis/dbader/node-datadog-metrics/master.svg?style=flat-square
[travis-url]: https://travis-ci.org/dbader/node-datadog-metrics
[wiki]: https://github.com/yourname/yourproject/wiki