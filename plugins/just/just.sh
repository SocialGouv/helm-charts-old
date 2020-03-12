#!/bin/bash

set -eu

charts_directory=${JUST_CHARTS_DIRECTORY:='.charts'}
manifests_directory=${JUST_MANIFESTS_DIRECTORY:='.manifests'}
temp_directory=${JUST_TEMP_DIRECTORY:='.tmp'}

chart_name_delimiter='/'
version_delimiter='#'


usage() {
cat << EOF
This allows storing and rendering Helm Charts in a deterministic way. No Tiller required.
Available Commands:
  apply     Apply a release from $manifests_directory.
  delete    Delete a release frome $manifests_directory.
  fetch     Fetches a chart and stores it in $charts_directory.
  render    Renders a chart from $charts_directory to $manifests_directory.

Examples:
  - helm just fetch "socialgouv/nodejs#2.4.1"
  - helm just render my-server nodejs
  - helm just apply my-server
  - helm just delete my-server
EOF
}

apply () {
  local release_name=$1

  shift;

  kubectl apply \
    -f \
    "$manifests_directory/$release_name" \
    "$@"
}

delete () {
  local release_name=$1

  shift;

  kubectl delete \
    -f \
    "$manifests_directory/$release_name" \
    "$@"
}

fetch() {
  local chart_url=$1

  shift;

  local regex="(.*)$chart_name_delimiter(.*)$version_delimiter(.*)"

  [[ $chart_url =~ $regex ]]
  chart_repo="${BASH_REMATCH[1]}"
  chart_name="${BASH_REMATCH[2]}"
  chart_version="${BASH_REMATCH[3]}"

  echo "Writing chart to $charts_directory/$chart_name"

  helm fetch \
    --untar \
    --untardir "$charts_directory" \
    --version "$chart_version" \
    "$chart_repo/$chart_name" \
    "$@"
}

render() {
  local release_name=$1
  shift;
  local chart_name=$1
  shift;

  echo -e "Rendering chart: \"$chart_name\" as $manifests_directory/$release_name/$chart_name"

  mkdir -p "$manifests_directory"
  rm -rf "${manifests_directory:?}/$release_name" || true

  mkdir -p "$temp_directory/$release_name"
  helm template \
    --name "$release_name" \
    --name-template "$release_name" \
    --output-dir "$temp_directory/$release_name" \
    "$charts_directory/$chart_name" \
    "$@"

  echo -e "Move \"$temp_directory/$release_name/$chart_name/templates\" to \"$manifests_directory/$release_name\""
  mv "$temp_directory/$release_name/$chart_name/templates" "$manifests_directory/$release_name"

  rm -rf ${temp_directory:?} || true
}

test () {
  local release_name=$1

  shift;

  kubectl apply \
    -f \
    "$manifests_directory/$release_name/tests" \
    "$@"

  kubectl get job --no-headers \
    -o custom-columns=":metadata.name" \
    -l "app.kubernetes.io/instance=$release_name" \
    -l "just=test" | \
    \
    xargs -I {} sh -xc "
  kubectl wait --for=condition=available job/{} --timeout=5s || true
  kubectl logs -f job/{}
  kubectl wait --for=condition=complete job/{} --timeout=5s
  kubectl delete job/{}
    "
}

case "${1:-"help"}" in
  "apply"):
    shift;
    apply "$@"
    ;;
  "delete"):
    shift;
    delete "$@"
    ;;
  "fetch"):
    shift;
    fetch "$@"
    ;;
  "render"):
    shift;
    render "$@"
    ;;
  "test"):
    shift;
    test "$@"
    ;;
  "help")
    usage
    ;;
  "--help")
    usage
    ;;
  "-h")
    usage
    ;;
  *)
    usage
    exit 1
    ;;
esac

exit 0
