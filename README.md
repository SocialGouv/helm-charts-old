# helm-charts

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