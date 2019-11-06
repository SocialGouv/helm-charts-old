# Helm Plugin "Just"

> Inspired by https://github.com/giantswarm/helm-nomagic (see https://blog.giantswarm.io/what-you-yaml-is-what-you-get/)

## TL;DR

```sh
$ curl -L https://github.com/SocialGouv/helm-charts/releases/download/v2.6.0/helm-just-linux-2.6.0.tgz | tar -C $(helm home) -xzv
$ helm repo add socialgouv https://github.com/SocialGouv/helm-charts/releases/download/v2.6.0
$ helm just fetch "socialgouv/nodejs#2.6.0"
$ helm just render my-server nodejs
$ helm just apply my-server
$ helm just delete my-server
```

