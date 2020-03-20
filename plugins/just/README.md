# Helm Plugin "Just"

> Inspired by https://github.com/giantswarm/helm-nomagic (see https://blog.giantswarm.io/what-you-yaml-is-what-you-get/)

## TL;DR

```sh
$ curl -L https://github.com/SocialGouv/helm-charts/releases/download/v2.8.0/helm-just-linux-2.8.0.tgz | tar -C $(helm home) -xzv
$ helm repo add socialgouv https://github.com/SocialGouv/helm-charts/releases/download/v2.8.0
$ helm just fetch "socialgouv/nodejs#2.8.0"
$ helm just render my-server nodejs
$ helm just apply my-server
$ helm just delete my-server
```

## Install

We recommend installing the `just` plugin from the GitHub Release assets.

```sh
# Ensure that helm is initialized
$ helm init --client-only
# Install `just` as helm plugin
$ curl -L https://github.com/SocialGouv/helm-charts/releases/download/v2.8.0/helm-just-linux-2.8.0.tgz | tar -C $(helm home) -xzv
```

### Local development installation

```sh
# Ensure you do not have a previous `just` plugin installed
# And install from this repo path
$ helm plugin remove just ; helm plugin install ./plugins/just
```

## Usage

### `helm just fetch "<repo>/<chart_name>#<chart_version>"`

> Fetch a chart an "cache" it locally for future renders  
> By default, cached chart are stored in you local `.chart` folder

```sh
# Stable charts https://hub.helm.sh/charts/stable
$ helm just fetch "stable/kube-ops-view#1.1.1"
#
# If you want to fetch our SocialGouv charts, don't forget to add `socialgouv` as helm repo
$ helm repo add socialgouv https://github.com/SocialGouv/helm-charts/releases/download/v2.8.0
$ helm just fetch "socialgouv/nodejs#2.8.0"
#
# Any extra arguments will be passed to `helm fetch`
# see `helm fetch --help`
$ helm just fetch "socialgouv/nodejs#2.8.0" --debug
```

### `helm just render <release_name> <chart_name>`

> Render a "cached" chart.  
> By default, cached chart are stored in you local `.chart` folder and rendered in you local `.manifests` folder

```sh
$ helm just render my-release nodejs
#
# Any extra arguments will be passed to `helm render`
# see `helm template --help`
$ helm just render "socialgouv/nodejs#2.8.0" --set image.tag="12-alpine"
```

### `helm just apply <release_name>`

> Apply a rendered chart.  
> By default, rendered charts are stored in you local `.manifests` folder

```sh
$ helm just apply my-release
#
# Any extra arguments will be passed to `helm apply`
# see `kubctl apply --help`
$ kubctl just apply my-release --debug
```

### `helm just delete <release_name>`

> Delete a rendered chart.  
> By default, rendered charts are stored in you local `.manifests` folder

```sh
$ helm just delete my-release
#
# Any extra arguments will be passed to `helm delete`
# see `kubctl delete --help`
$ kubctl just delete my-release --debug
```

## Options

### `JUST_CHARTS_DIRECTORY`

You can change the base chart directory by setting a `JUST_CHARTS_DIRECTORY` env variable.

```sh
$ export JUST_CHARTS_DIRECTORY=".charts" # by default
```

### `JUST_MANIFESTS_DIRECTORY`

You can change the base manifests directory by setting a `JUST_MANIFESTS_DIRECTORY` env variable.

```sh
$ export JUST_MANIFESTS_DIRECTORY=".manifests" # by default
```

### `JUST_TEMP_DIRECTORY`

You can change the base tmp directory by setting a `JUST_TEMP_DIRECTORY` env variable.

```sh
$ export JUST_TEMP_DIRECTORY=".tmp" # by default
```
