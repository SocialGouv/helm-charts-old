# Contributing to SocialGouv/helm-charts

You need [Helm](https://helm.sh) to contribute. You can install it locally or use it from a container.

```sh
# Run a container as command
# From https://hub.docker.com/r/alpine/helm
alias helm="docker run -ti --rm -v $(pwd):/apps -v ~/.kube:/root/.kube -v ~/.helm:/root/.helm --user $(id -u):$(id -g) alpine/helm"
```

## Create a new chart

1. Create a chart from the official boilerplate

```bash
$ helm create charts/<chart_name>
```

1. Add a `README.md`  
   Ensure to add a documentation right from the start with a `README.md`.  
   You can follow the [`certificate/README.md` as model](./charts/certificate/README.md).

1. Add your chart to the table in the [root `README.md`](./README.md).  
   Keep alpha sorted plz ;)

1. Add a `.gitlab-ci.yml` to specify the chart tests  
   Ensure to add a test right from the start with in a local `.gitlab-ci.yml`.  
   You can follow the [`certificate/.gitlab-ci.yml` as model](./charts/certificate/.gitlab-ci.yml).

1. Include this `.gitlab-ci.yml` in the root `.gitlab-ci.yml`.

1. Edit the local `Chart.yaml`  
   I recommend that you pick an images from wikimedia ;)  
   Ensure that the version in the local `Chart.yaml` is the same as the other.  
   You can follow the [`certificate/Chart.yaml` as model](./charts/certificate/.gitlab-ci.yml).

## Tips

```sh
$ export CHART=nodejs
$ export RELEASE_NAME=helm-charts-$CHART-local
# To purge and re-run your test
$ helm delete --purge $RELEASE_NAME ; helm upgrade $RELEASE_NAME ./charts/$CHART --debug --install --values ./charts/$CHART/values.test.yaml --wait && helm test $RELEASE_NAME --cleanup || helm test $RELEASE_NAME
```

## Release policy

### One click semantic release !

[On a successful `master` branch pipeline click on trigger the `Release` job.](https://gitlab.factory.social.gouv.fr/SocialGouv/helm-charts/pipelines)

### Manual

We manly use [semantic-release](https://github.com/semantic-release/semantic-release) to generate our release
You need an [Github token](https://github.com/settings/tokens/new) to release.

```sh
$ export GITHUB_TOKEN=**********
$ yarn global add semantic-release @semantic-release/changelog @semantic-release/exec @semantic-release/git
$ semantic-release
```

Our [semantic-release config](./.releaserc.yml) will do the heavy lifting ;)

## Testing

### [Bats](https://github.com/sstephenson/bats)

```sh
# Ensure to launch tests on the `helm-charts-test` namespace
$ kubectl config set-context --current --namespace=helm-charts-test
#
$ bats ./charts/<my_chart>/test/
```

### Manual deployment

```sh
# You can install the local version of the just plugin by running
$ helm plugin remove just ; helm plugin install ./plugins/just

# You can make the plugin
$ JUST_CHARTS_DIRECTORY=charts helm just render <release_name> <chart_name>
# for example
$ JUST_CHARTS_DIRECTORY=charts helm just render my-managed-pg-test managed-pg

$ JUST_CHARTS_DIRECTORY=charts helm just test <release_name>
# for example
$ JUST_CHARTS_DIRECTORY=charts helm just test my-managed-pg-test
```
