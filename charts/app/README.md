# Social Gouv App

> Social Gouv app chart

## TL;DR

```sh
$ helm install socialgouv/app
#
$ helm upgrade my-release socialgouv/app --install
```

## Introduction

This chart bootstraps an socialgouv app on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.14+
- Helm 2.14+

## Installing the Chart

To install the chart with the release name `my-release`:

```sh
$ helm install socialgouv/app --name my-release
#
$ helm upgrade my-release socialgouv/app --install
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

| Parameter                                              | Description                                    | Default                               |
| ------------------------------------------------------ | ---------------------------------------------- | ------------------------------------- |
| `image.pullPolicy`                                     | NodeJs Image pull policy                       | `IfNotPresent`                        |
| `image.repository`                                     | NodeJs Image name                              | `node`                                |
| `image.tag`                                            | NodeJs Image tag                               | `lts-alpine`                          |
| `deployment.annotations`                               | Annotations for the Deployment                 | `{}`                                  |
| `deployment.env`                                       | Environment variables                          | `[{PORT: 80, NODE_ENV: "production"}` |
| `deployment.envFrom`                                   | Environment variables from secrets             | `null`                                |
| `deployment.imagePullSecrets`                          | Specify Image pull secrets                     | `[]`                                  |
| `deployment.initContainers`                            | Init Containers                                | `[]`                                  |
| `deployment.livenessProbe.initialDelaySeconds`         | Delay before first liveness                    | `5`                                   |
| `deployment.livenessProbe.path`                        | Path for the liveness                          | `/`                                   |
| `deployment.livenessProbe.periodSeconds`               | Liveness period                                | `10`                                  |
| `deployment.livenessProbe.failureThreshold`            | Number of allowed failures                     | `10`                                  |
| `deployment.livenessProbe.timeoutSeconds`              | Probe request timeout                          | `10`                                  |
| `deployment.port`                                      | Container port                                 | `80`                                  |
| `deployment.readinessProbe.initialDelaySeconds`        | Delay before first readiness                   | `5`                                   |
| `deployment.readinessProbe.path`                       | Path for the readiness                         | `/`                                   |
| `deployment.readinessProbe.periodSeconds`              | Readiness period                               | `10`                                  |
| `deployment.readinessProbe.failureThreshold`           | Number of allowed failures                     | `10`                                  |
| `deployment.readinessProbe.timeoutSeconds`             | Probe request timeout                          | `10`                                  |
| `deployment.replicaCount`                              | replica count                                  | `1`                                   |
| `deployment.resources`                                 | CPU/Memory resource requests/limits            | Memory: `16-32Mi`, CPU: `5-50m`       |
| `deployment.volumeMounts`                              | The volumes you need to mount on the container | `[]`                                  |
| `deployment.volumes`                                   | The volumes you need to define                 | `[]`                                  |
| `ingress.annotations`                                  | Annotations for the Ingress                    | `{}`                                  |
| `ingress.enabled`                                      | Enable ingress                                 | `false`                               |
| `ingress.hosts`                                        | Hosts for the Ingress                          | `[]`                                  |
| `ingress.tls`                                          | Tls for the Ingress                            | `[]`                                  |
| `labels`                                               | Extra label to add deploy, srv, and ing        | `{}`                                  |
| `service.port`                                         | NodeJs port                                    | `ClusterIP`                           |
| `service.type`                                         | Kubernetes Service type                        | `ClusterIP`                           |
| `autoscaling.enabled`                                  | If true, creates Horizontal Pod Autoscaler     | `false`                               |
| `autoscaling.minReplicas`                              | Minimum pod replica count                      | `null`                                |
| `autoscaling.maxReplicas`                              | Maximum pod replica count                      | `null`                                |
| `autoscaling.targetCPUAverageUtilizationPercentage`    | Target CPU utilization percentage to scale     | `null`                                |
| `autoscaling.targetMemoryAverageUtilizationPercentage` | Target memory utilization percentage to scale  | `null`                                |

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install` or `helm update`.

## Additional values

You will find in the [`values.socialgouv.yaml`](./values.socialgouv.yaml) additional values that will help most Social Gouv project deploying from GitLab.

```sh
# On GitLab
# The `values.socialgouv.yaml` requires a PORT to be defined !
$ export PORT=80
$ envsubst < ./charts/app/values.socialgouv.yaml > /tmp/values.socialgouv.yaml
$ helm upgrade my-release socialgouv/app
  --install
  --values /tmp/values.socialgouv.yaml
```
