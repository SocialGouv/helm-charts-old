<h1 align="center">
  <img src="https://github.com/SocialGouv/helm-charts/raw/master/.github/boat.gif" width="250"/>
  <p align="center">Helm Charts</p>
  <p align="center" style="font-size: 0.5em">🧹The Social Gouv Helm Charts✨</p>
</h1>

<p align="center">
  <a href="https://gitlab.factory.social.gouv.fr/SocialGouv/helm-charts/pipelines"><img src="https://gitlab.factory.social.gouv.fr/SocialGouv/helm-charts/badges/master/pipeline.svg" alt="Gitlab Master Build Status"></a>
  <a href="https://travis-ci.com/SocialGouv/helm-charts"><img src="https://travis-ci.com/SocialGouv/helm-charts.svg?branch=master" alt="Travis Build Status"></a>
  <a href="https://opensource.org/licenses/Apache-2.0"><img src="https://img.shields.io/badge/License-Apache--2.0-yellow.svg" alt="License: Apache-2.0"></a>
  <a href="https://github.com/SocialGouv/helm-charts/releases "><img alt="GitHub release (latest SemVer)" src="https://img.shields.io/github/v/release/SocialGouv/helm-charts?sort=semver"></a>
</p>

<br>
<br>
<br>
<br>

## Usage

```
$ helm repo add socialgouv https://socialgouv.github.io/helm-charts/
$ helm install socialgouv/<chart> --version <version>
```

## Helm charts

| Project    | Chart                                                                                      | Version                                                                                                                                                     | Links                                                                                                                               |
| ---------- | ------------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------- |
| **webapp** | [`socialgouv/webapp`](./charts/webapp) | [![latest](https://img.shields.io/npm/v/@socialgouv/eslint-config-recommended/latest.svg)](https://npmjs.com/package/@socialgouv/eslint-config-recommended) | [![README](https://img.shields.io/badge/README--green.svg)](./charts/webapp/README.md) |

<br>
<br>
<br>
<br>

## Contribute

You need [Helm](https://helm.sh) to contribute. You can install it locally or use it from a container.

```sh
# Run a container as command
# From https://hub.docker.com/r/alpine/helm
alias helm="docker run -ti --rm -v $(pwd):/apps -v ~/.kube:/root/.kube -v ~/.helm:/root/.helm --user $(id -u):$(id -g) alpine/helm"
```

### Create a new chart

```bash
$ helm create charts/<chart_name>
```

Ensure to add a documentation right from the start with a `README.md`.  
You can follow the [`webapp/README.md` as model](./charts/webapp/README.md).

## Release policy

### One click semantic release !

[On a successful `master` branch pipeline click on trigger the `Release` job.](https://gitlab.factory.social.gouv.fr/SocialGouv/helm-charts/pipelines)

### Manual

We manly use [semantic-release](https://github.com/semantic-release/semantic-release) to generate our relese
You need an [Github token](https://github.com/settings/tokens/new) to release.

```sh
$ export GITHUB_TOKEN=**********
$ yarn global add semantic-release @semantic-release/changelog @semantic-release/exec @semantic-release/git
$ semantic-release
```

Our [semantic-release config](./.releaserc.yml) will do the heavy lifting ;)
