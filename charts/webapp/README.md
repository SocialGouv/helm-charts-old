# Web App

> Single page application chart

## TL;DR

```sh
$ helm install socialgouv/webapp
```

## Introduction

This chart bootstraps a webapp deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.6+

## Installing the Chart

To install the chart with the release name `my-release`:

```sh
$ helm install stable/webapp --name my-release
```

The command deploys webapp on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```console
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following table lists the configurable parameters of the webapp chart and their default values.

| Parameter | Description | Default |
| --------- | ----------- | ------- |

