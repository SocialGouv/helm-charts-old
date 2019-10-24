# Contributing to SocialGouv/helm-charts

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

We manly use [semantic-release](https://github.com/semantic-release/semantic-release) to generate our release
You need an [Github token](https://github.com/settings/tokens/new) to release.

```sh
$ export GITHUB_TOKEN=**********
$ yarn global add semantic-release @semantic-release/changelog @semantic-release/exec @semantic-release/git
$ semantic-release
```

Our [semantic-release config](./.releaserc.yml) will do the heavy lifting ;)
