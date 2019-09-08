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

Helm Charts to deploy MAS Incubateur apps in Kubernetes. 

## How to create/update an helm repo with github pages

* Enable github pages in your repo settings

* Create a helm chart
```bash
$ helm create <chart_name>
```

* Package the helm chart
```bash
$ helm package <chart_name>
```

* Create the index.yaml that has a list of all of the packages supplied by the repository
```bash
$ helm repo index . --url https://socialgouv.github.io/helm-charts/
```

* Push/merge to master

## How to add the helm repo

```bash
$ helm repo add mas-incubateur https://socialgouv.github.io/helm-charts/
```
