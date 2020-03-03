# [4.0.0](https://github.com/SocialGouv/helm-charts/compare/v3.0.1...v4.0.0) (2020-03-03)


* refactor(certificate)!: remove certificate chart (#43) ([2d487f5](https://github.com/SocialGouv/helm-charts/commit/2d487f5b0ceb516dd8307c692d8ee91b1143c569)), closes [#43](https://github.com/SocialGouv/helm-charts/issues/43) [#23](https://github.com/SocialGouv/helm-charts/issues/23)


### BREAKING CHANGES

* remove certificate chart

## [3.0.1](https://github.com/SocialGouv/helm-charts/compare/v3.0.0...v3.0.1) (2020-01-22)


### Bug Fixes

* add missing probe port in examples values files ([#37](https://github.com/SocialGouv/helm-charts/issues/37)) ([eb2b4bf](https://github.com/SocialGouv/helm-charts/commit/eb2b4bfe8040f3a5f64de4bf7732e7d1d806d9f3))
* fix healthcheck probes port (replace name by port) ([#36](https://github.com/SocialGouv/helm-charts/issues/36)) ([bcb4adc](https://github.com/SocialGouv/helm-charts/commit/bcb4adc804f3cd7934cbc42b0fddc97d4f45624a))

# [3.0.0](https://github.com/SocialGouv/helm-charts/compare/v2.14.0...v3.0.0) (2020-01-10)


* feat(nodejs)!: set variable for backend.servicePort in ingress template ([9fa47cc](https://github.com/SocialGouv/helm-charts/commit/9fa47cc663966ce6a5c0de6e7bb3ab13d1dd2204))
* feat(hpa)!: set variable for backend.servicePort in ingress template ([8452729](https://github.com/SocialGouv/helm-charts/commit/84527297d3ac15972377bdd758dc0ac07d36e434))


### BREAKING CHANGES

* set variable for backend.servicePort in ingress template

In the value file, the `ingress.hosts[].paths` accepts an array of object

Before

```yaml
ingress:
  hosts:
    - host: test.dev.fabrique.social.gouv.fr
      paths:
        - /
```

After

```yaml
ingress:
  hosts:
    - host: test.dev.fabrique.social.gouv.fr
      paths:
        - path: /
```

The `servicePort`, default to `80`, can be overridden there

```yaml
ingress:
  hosts:
    - host: test.dev.fabrique.social.gouv.fr
      paths:
        - path: /
          servicePort: 8080
```
* set variable for backend.servicePort in ingress template

In the value file, the `ingress.hosts[].paths` accepts an array of object

Before

```yaml
ingress:
  hosts:
    - host: test.dev.fabrique.social.gouv.fr
      paths:
        - /
```

After

```yaml
ingress:
  hosts:
    - host: test.dev.fabrique.social.gouv.fr
      paths:
        - path: /
```

The `servicePort`, default to `80`, can be overridden there

```yaml
ingress:
  hosts:
    - host: test.dev.fabrique.social.gouv.fr
      paths:
        - path: /
          servicePort: 8080
```

# ~~[2.14.0](https://github.com/SocialGouv/helm-charts/compare/v2.13.0...v2.14.0) (2020-01-09)~~

**DEPRECATED** : Contains breaking changes

### Features

* set variable for backend.servicePort in ingress template ([#34](https://github.com/SocialGouv/helm-charts/issues/34)) ([d3929bd](https://github.com/SocialGouv/helm-charts/commit/d3929bd99f99f015e0f9e68220c8e0202b43f6eb))

# [2.13.0](https://github.com/SocialGouv/helm-charts/compare/v2.12.0...v2.13.0) (2019-12-30)


### Features

* **nodejs:** add annotations to deploy pod too ([#32](https://github.com/SocialGouv/helm-charts/issues/32)) ([69c4864](https://github.com/SocialGouv/helm-charts/commit/69c48641cd1fab9be1011bcdb2589a5099a5ef4b))

# [2.12.0](https://github.com/SocialGouv/helm-charts/compare/v2.11.0...v2.12.0) (2019-12-23)


### Features

* **just:** add directory change options ([#29](https://github.com/SocialGouv/helm-charts/issues/29)) ([98cfaee](https://github.com/SocialGouv/helm-charts/commit/98cfaee5e01bf1c2e94ecc38ef04f5eeadfe4fbc))
* **nodejs:** add labels variable ([#30](https://github.com/SocialGouv/helm-charts/issues/30)) ([bdb43aa](https://github.com/SocialGouv/helm-charts/commit/bdb43aab26459f65a78e249ed999fb7c4c253c9a))

# [2.11.0](https://github.com/SocialGouv/helm-charts/compare/v2.10.0...v2.11.0) (2019-12-19)


### Features

* add variable for service targetPort ([#27](https://github.com/SocialGouv/helm-charts/issues/27)) ([e12538a](https://github.com/SocialGouv/helm-charts/commit/e12538ac4d9aebea1aa357c793a933d2666cd653))

# [2.10.0](https://github.com/SocialGouv/helm-charts/compare/v2.9.0...v2.10.0) (2019-12-18)


### Features

* variabilize port for Probe in hpa charts + update memory limits ([#26](https://github.com/SocialGouv/helm-charts/issues/26)) ([deaadbd](https://github.com/SocialGouv/helm-charts/commit/deaadbdec769147892402cdbc6cf024f05d964c9))

# [2.9.0](https://github.com/SocialGouv/helm-charts/compare/v2.8.0...v2.9.0) (2019-12-06)


### Bug Fixes

* allow override failureThreshold and timeoutSeconds ([#20](https://github.com/SocialGouv/helm-charts/issues/20)) ([eccff42](https://github.com/SocialGouv/helm-charts/commit/eccff42df7901c3af7f46a724deb058ee38977a5))


### Features

* add chart to use Horizontal Pod Autoscaler ([#22](https://github.com/SocialGouv/helm-charts/issues/22)) ([5050753](https://github.com/SocialGouv/helm-charts/commit/5050753716e1e367b4db0732de81af7f2baa4675))

# [2.8.0](https://github.com/SocialGouv/helm-charts/compare/v2.7.0...v2.8.0) (2019-11-25)


### Features

* **nodejs:** add deployment.annotations variable ([#18](https://github.com/SocialGouv/helm-charts/issues/18)) ([9ef532c](https://github.com/SocialGouv/helm-charts/commit/9ef532cd75bd64c47b6cd41c65f76d553c8004f0))
* **nodejs:** add deployment.initContainers variable ([#19](https://github.com/SocialGouv/helm-charts/issues/19)) ([57c61eb](https://github.com/SocialGouv/helm-charts/commit/57c61eb95b06f42e3d957e74ba13174266001008))

# [2.7.0](https://github.com/SocialGouv/helm-charts/compare/v2.6.0...v2.7.0) (2019-11-18)


### Features

* **nodejs:** add deployment.port variable ([#17](https://github.com/SocialGouv/helm-charts/issues/17)) ([d031006](https://github.com/SocialGouv/helm-charts/commit/d031006008cf2a005e723a4aaa2764a8a12bbe68))

# [2.6.0](https://github.com/SocialGouv/helm-charts/compare/v2.5.0...v2.6.0) (2019-11-06)


### Features

* **just:** add just plugin ([#14](https://github.com/SocialGouv/helm-charts/issues/14)) ([f1dd4ed](https://github.com/SocialGouv/helm-charts/commit/f1dd4ed420be7628fc2f172d300ce6bd5f177a18))

# [2.5.0](https://github.com/SocialGouv/helm-charts/compare/v2.4.2...v2.5.0) (2019-10-29)


### Features

* **nodejs:** add path variable for liveness and readiness ([0464d87](https://github.com/SocialGouv/helm-charts/commit/0464d87d198790a758255af817be53ec73728ea6))

## [2.4.2](https://github.com/SocialGouv/helm-charts/compare/v2.4.1...v2.4.2) (2019-10-28)


### Bug Fixes

* **nodejs:** use longer periods by default ([369f940](https://github.com/SocialGouv/helm-charts/commit/369f94007ab7c48a008f9106326e063dfb745b37))

## [2.4.1](https://github.com/SocialGouv/helm-charts/compare/v2.4.0...v2.4.1) (2019-10-28)


### Bug Fixes

* **nodejs:** change period ([c1c3964](https://github.com/SocialGouv/helm-charts/commit/c1c3964361602d20a66c1fa0f2a10492d121cc36))

# [2.4.0](https://github.com/SocialGouv/helm-charts/compare/v2.3.0...v2.4.0) (2019-10-28)


### Features

* **nodejs:** add liveness and readiness values ([9adcd59](https://github.com/SocialGouv/helm-charts/commit/9adcd592dba388731de7b3bbbf51d88c895bb01c))

# [2.3.0](https://github.com/SocialGouv/helm-charts/compare/v2.2.0...v2.3.0) (2019-10-28)


### Features

* **nodejs:** add nodejs charts ([8320df8](https://github.com/SocialGouv/helm-charts/commit/8320df839b0a1f37fc0067c95ee3a374d05a881a))

# [2.2.0](https://github.com/SocialGouv/helm-charts/compare/v2.1.0...v2.2.0) (2019-10-24)


### Features

* **certificate:** create socialgouv/certificate chart ([#10](https://github.com/SocialGouv/helm-charts/issues/10)) ([8c06e54](https://github.com/SocialGouv/helm-charts/commit/8c06e5446b75016460b90c4c8d12e9981aa0aefd))

# [2.1.0](https://github.com/SocialGouv/helm-charts/compare/v2.0.3...v2.1.0) (2019-10-08)


### Features

* add ingress annotation to redirect http to https ([9765f39](https://github.com/SocialGouv/helm-charts/commit/9765f39))
* add ingress annotation to redirect http to https ([76e4d2f](https://github.com/SocialGouv/helm-charts/commit/76e4d2f))

## [2.0.3](https://github.com/SocialGouv/helm-charts/compare/v2.0.2...v2.0.3) (2019-10-08)


### Bug Fixes

* wrong identation for resources limits ([917ceb0](https://github.com/SocialGouv/helm-charts/commit/917ceb0))
* wrong identation resources ([3ef74ab](https://github.com/SocialGouv/helm-charts/commit/3ef74ab))

## [2.0.2](https://github.com/SocialGouv/helm-charts/compare/v2.0.1...v2.0.2) (2019-10-08)


### Bug Fixes

* misspelling release ([4e71b16](https://github.com/SocialGouv/helm-charts/commit/4e71b16))
* misspelling release ([fff5c6a](https://github.com/SocialGouv/helm-charts/commit/fff5c6a))

## [2.0.1](https://github.com/SocialGouv/helm-charts/compare/v2.0.0...v2.0.1) (2019-09-30)


### Bug Fixes

* force bump to test release process ([d549779](https://github.com/SocialGouv/helm-charts/commit/d549779))

# [2.0.0](https://github.com/SocialGouv/helm-charts/compare/v1.0.8...v2.0.0) (2019-09-10)


### Bug Fixes

* **index:** correct urls ([74dfb15](https://github.com/SocialGouv/helm-charts/commit/74dfb15))
* **webapp:** use port 80 as default deployment and service port ([2fbe4e6](https://github.com/SocialGouv/helm-charts/commit/2fbe4e6))


### Code Refactoring

* mode all charts to charts folder ([83f1b90](https://github.com/SocialGouv/helm-charts/commit/83f1b90))


### BREAKING CHANGES

* might affect the build process

## [1.0.8](https://github.com/SocialGouv/helm-charts/compare/v1.0.7...v1.0.8) (2019-09-08)


### Bug Fixes

* **release:** use gitTag instead of version in github url ([60d4a12](https://github.com/SocialGouv/helm-charts/commit/60d4a12))

## [1.0.7](https://github.com/SocialGouv/helm-charts/compare/v1.0.6...v1.0.7) (2019-09-08)


### Bug Fixes

* **ci:** force bump to test release process ([593f64f](https://github.com/SocialGouv/helm-charts/commit/593f64f))

## [1.0.6](https://github.com/SocialGouv/helm-charts/compare/v1.0.5...v1.0.6) (2019-09-08)


### Bug Fixes

* **ci:** force bump to test release process ([6c13db8](https://github.com/SocialGouv/helm-charts/commit/6c13db8))

## [1.0.5](https://github.com/SocialGouv/helm-charts/compare/v1.0.4...v1.0.5) (2019-09-08)


### Bug Fixes

* **ci:** force bump to test release process ([719152f](https://github.com/SocialGouv/helm-charts/commit/719152f))

## [1.0.4](https://github.com/SocialGouv/helm-charts/compare/v1.0.3...v1.0.4) (2019-09-08)


### Bug Fixes

* **ci:** force bump to test release process ([c05d7d8](https://github.com/SocialGouv/helm-charts/commit/c05d7d8))
* **ci:** force bump to test release process ([5026c80](https://github.com/SocialGouv/helm-charts/commit/5026c80))
* **ci:** force bump to test release process (2) ([2971fa1](https://github.com/SocialGouv/helm-charts/commit/2971fa1))

## [1.0.3](https://github.com/SocialGouv/helm-charts/compare/v1.0.2...v1.0.3) (2019-09-08)


### Bug Fixes

* **ci:** force bump to test release process ([c988319](https://github.com/SocialGouv/helm-charts/commit/c988319))
* **ci:** force bump to test release process ([562e203](https://github.com/SocialGouv/helm-charts/commit/562e203))

## [1.0.2](https://github.com/SocialGouv/helm-charts/compare/v1.0.1...v1.0.2) (2019-09-08)


### Bug Fixes

* **ci:** force bump to test release process ([ddf59e7](https://github.com/SocialGouv/helm-charts/commit/ddf59e7))

## [1.0.1](https://github.com/SocialGouv/helm-charts/compare/v1.0.0...v1.0.1) (2019-09-06)


### Bug Fixes

* **ci:** force bump to test release process ([23972bd](https://github.com/SocialGouv/helm-charts/commit/23972bd))

# 1.0.0 (2019-09-06)


### Bug Fixes

* chart ingress ([16fd2a5](https://github.com/SocialGouv/helm-charts/commit/16fd2a5))
* set variable for app name ([03effa1](https://github.com/SocialGouv/helm-charts/commit/03effa1))


### Features

* add env variable for deployment ([f689774](https://github.com/SocialGouv/helm-charts/commit/f689774))
* add helm chart to deploy incubateur mas webapp ([0f968c5](https://github.com/SocialGouv/helm-charts/commit/0f968c5))
* create helm repo ([056dade](https://github.com/SocialGouv/helm-charts/commit/056dade))
* package webapp chart ([030aea2](https://github.com/SocialGouv/helm-charts/commit/030aea2))
