# Managed Postgres

> Managed Postgres chart

## TL;DR

```sh
$ helm just install socialgouv/managed-pg#<version>
#
$ helm just render my-managed-pg-${CI_JOB_ID} managed-pg
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
      --set createDb.name=db_${CI_COMMIT_REF_SLUG}
      --set createDb.password=pass_${CI_COMMIT_REF_SLUG}
      --set createDb.user=user_${CI_COMMIT_REF_SLUG}
    #
    - helm just apply helm-chart-managed-pg-test-${CI_JOB_ID} -l app=create-db
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
$ helm just apply my-release -l app=create-db
```

The command deploys with [the default configuration](./values.yaml). The [configuration](#configuration) section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```console
$ helm delete --purge my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following table lists the configurable parameters of the chart and their default values.

| Parameter                                       | Description                             | Default                               |
| ----------------------------------------------- | --------------------------------------- | ------------------------------------- |
| `image.pullPolicy`                              | managed-pg Image pull policy                | `IfNotPresent`                        |
| `image.repository`                              | managed-pg Image name                       | `node`                                |
| `image.tag`                                     | managed-pg Image tag                        | `lts-alpine`                          |
| `deployment.annotations`                        | Annotations for the Deployment          | `{}`                                  |
| `deployment.env`                                | Environment variables                   | `[{PORT: 80, NODE_ENV: "production"}` |
| `deployment.imagePullSecrets`                   | Specify Image pull secrets              | `[]`                                  |
| `deployment.initContainers`                     | Init Containers                         | `[]`                                  |
| `deployment.livenessProbe.initialDelaySeconds`  | Delay before first liveness             | `5`                                   |
| `deployment.livenessProbe.path`                 | Path for the liveness                   | `/`                                   |
| `deployment.livenessProbe.periodSeconds`        | Liveness period                         | `10`                                  |
| `deployment.livenessProbe.failureThreshold`     | Number of allowed failures              | `10`                                  |
| `deployment.livenessProbe.timeoutSeconds`       | Probe request timeout                   | `10`                                  |
| `deployment.port`                               | Container port                          | `80`                                  |
| `deployment.readinessProbe.initialDelaySeconds` | Delay before first readiness            | `5`                                   |
| `deployment.readinessProbe.path`                | Path for the readiness                  | `/`                                   |
| `deployment.readinessProbe.periodSeconds`       | Readiness period                        | `10`                                  |
| `deployment.readinessProbe.failureThreshold`    | Number of allowed failures              | `10`                                  |
| `deployment.readinessProbe.timeoutSeconds`      | Probe request timeout                   | `10`                                  |
| `deployment.replicaCount`                       | replica count                           | `1`                                   |
| `deployment.resources`                          | CPU/Memory resource requests/limits     | Memory: `16-32Mi`, CPU: `5-50m`       |
| `ingress.annotations`                           | Annotations for the Ingress             | `{}`                                  |
| `ingress.enabled`                               | Enable ingress                          | `false`                               |
| `ingress.hosts`                                 | Hosts for the Ingress                   | `[]`                                  |
| `ingress.tls`                                   | Tls for the Ingress                     | `[]`                                  |
| `labels`                                        | Extra label to add deploy, src, and ing | `{}`                                  |
| `service.port`                                  | managed-pg port                             | `ClusterIP`                           |
| `service.type`                                  | Kubernetes Service type                 | `ClusterIP`                           |

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install` or `helm update`.
