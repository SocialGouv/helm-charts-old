# Managed Postgres

> Managed Postgres chart

## TL;DR

```sh
$ helm just fetch socialgouv/managed-pg#<version>
#
$ helm just render my-managed-pg managed-pg
# To create a db and a user
$ helm just apply my-managed-pg managed-pg -l app=create-db-user
# To drop a db and a user
$ helm just apply my-managed-pg managed-pg -l app=drop-db-user
```

```yaml
variables:
  HELM_CHART_VERSION: "3.0.0"
  K8S_NAMESPACE: "${KUBE_NAMESPACE}"

Create db:
  environment:
    name: fabrique-dev
  image: registry.gitlab.factory.social.gouv.fr/socialgouv/docker/helm:0.25.0
  variables:
    JUST_CHARTS_DIRECTORY: charts
  script:
    - helm init --client-only
    - curl -L https://github.com/SocialGouv/helm-charts/releases/download/v${HELM_CHART_VERSION}/helm-just-linux-${HELM_CHART_VERSION}.tgz | tar -C $(helm home) -xzv
    - helm repo add socialgouv https://github.com/SocialGouv/helm-charts/releases/download/v${HELM_CHART_VERSION}
    #
    - echo "helm just fetch socialgouv/nodejs#${HELM_CHART_VERSION}"
    - helm just fetch "socialgouv/managed-pg#${HELM_CHART_VERSION}"
    #
    - helm just render helm-chart-managed-pg-test-${CI_JOB_ID} managed-pg
      --set db.name=db_${CI_COMMIT_REF_SLUG}
      --set db.password=pass_${CI_COMMIT_REF_SLUG}
      --set db.user=user_${CI_COMMIT_REF_SLUG}
    #
    - helm just apply helm-chart-managed-pg-test-${CI_JOB_ID} -l app=create-db-user
```

## Introduction

This chart bootstraps a managed postgres on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.14+
- Helm 2.14+

## Installing the Chart with just

To install the chart with the release name `my-release`:

```sh
$ helm just render my-release managed-pg
$ helm just apply my-release -l app=create-db-user
```

The command deploys with [the default configuration](./values.yaml). The [configuration](#configuration) section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
$ helm just delete my-release
# or
$ helm just delete my-release -l app=drop-db-user
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following table lists the configurable parameters of the chart and their default values.

| Parameter          | Description                         | Default                                                             |
| ------------------ | ----------------------------------- | ------------------------------------------------------------------- |
| `image.pullPolicy` | Jobs image pull policy              | `IfNotPresent`                                                      |
| `image.repository` | Jobs image name                     | `registry.gitlab.factory.social.gouv.fr/socialgouv/docker/azure-db` |
| `image.tag`        | Jobs image tag                      | `0.28.0`                                                            |
| `db`               | The postgres database job subject   | `[{name: "new_db", user: "new_user", password: "new_pass"}]`        |
| `env`              | Environment variables               | `[{PGSSLMODE: "require", PGHOST: "", PGUSER: "", PGPASSWORD: ""}]`  |
| `resources`        | CPU/Memory resource requests/limits | Memory: `0-512Mi`, CPU: `0-1000m`                                   |
| `restartPolicy`    | Jobs restart policy                 | `Never`                                                             |

Specify each parameter using the `--set key=value[,key=value]` argument to `helm just render`.
