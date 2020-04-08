#

load /usr/lib/bats-support/load.bash
load /usr/lib/bats-assert/load.bash

export JUST_CHARTS_DIRECTORY="charts"

HASHED=${CI_COMMIT_SHORT_SHA:="local"}

test_job () {
  TEST_JOB="${1}"
  RELEASE_NAME=${RELEASE_NAME:="${TEST_JOB}-test-${HASHED}"}
  JOB_NAME="${RELEASE_NAME}-managed-pg-${TEST_JOB}"
  JOB_ID="job.batch/${JOB_NAME}"
  TEST_JOB_ID="job.batch/test-${JOB_NAME}"
}

job_success () {
  # echo "$ kubectl wait --for=condition=available --timeout=10s ${JOB_ID}" >&2
  # run kubectl wait --for=condition=available --timeout=10s "${JOB_ID}" >&2
  # kubectl get "${JOB_ID}" -o yaml >&2
  # assert_success

  k8s_job_wait () {
    echo "kubectl wait --for=condition=$1 --timeout=1m ${JOB_ID}"
    kubectl wait --for=condition=$1 --timeout=1m "${JOB_ID}"
    echo "k8s_job_wait $1 done with $?"
    case "${1-}" in
      "failed")
        return 1
      ;;
      *)
        return $?
      ;;
    esac
  }
  export JOB_ID
  export -f k8s_job_wait
  run parallel \
    --env JOB_ID \
    --halt now,done=1 \
    k8s_job_wait ::: failed complete

  echo "$ kubectl wait --for=condition=failed --timeout=10s ${JOB_ID}" >&2
  echo "$ kubectl get pod -l job-name=${JOB_NAME}" >&2
  kubectl get pod -l job-name="${JOB_NAME}" >&2
  echo "$ kubectl get events --sort-by='{.lastTimestamp}' | tac | head" >&2
  kubectl get events --sort-by='{.lastTimestamp}' | tac | head >&2 || true
  # echo "$ kubectl get events --field-selector involvedObject.name=migrate-test-local-managed-pg-migrate-zsr2b" >&2
  # kubectl get events --field-selector involvedObject.name=migrate-test-local-managed-pg-migrate-zsr2b >&2 || true
  echo "$ kubectl logs ${JOB_ID}" >&2
  kubectl logs "${JOB_ID}" >&2
  assert_success
}

setup() {
  if [[ "$BATS_TEST_NUMBER" -eq 1 ]]; then
    setup_all || true
  fi

  # NODE(douglasduteil): manual bail mode
  [ ! -f "${BATS_PARENT_TMPNAME}.skip" ] || skip "skip remaining tests"
}

teardown() {
  if [[ "${#BATS_TEST_NAMES[@]}" -eq "$BATS_TEST_NUMBER" ]]; then
    teardown_all || true
  fi

  # NODE(douglasduteil): manual bail mode
  [ -n "$BATS_TEST_COMPLETED" ] || touch "${BATS_PARENT_TMPNAME}.skip"
}
