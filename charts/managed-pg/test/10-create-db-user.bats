#!/usr/bin/env bats

load /usr/lib/bats-support/load.bash
load /usr/lib/bats-assert/load.bash

export JUST_CHARTS_DIRECTORY="charts"

HASHED=$CI_COMMIT_SHORT_SHA
RELEASE_NAME=${RELEASE_NAME:="create-db-user-test-${HASHED}"}

setup() {
  helm just delete "${RELEASE_NAME}" -l app=create-db-user || true
}

teardown() {
  helm just delete "${RELEASE_NAME}" -l app=create-db-user || true
}

@test "should create a database and a user" {
  run helm just render "${RELEASE_NAME}" managed-pg \
    --set db.name="db_${HASHED}" \
    --set db.password="pass_${HASHED}" \
    --set db.user="user_${HASHED}"

  cat .manifests/${RELEASE_NAME}/job-create-db-user.yml

  assert_line "Rendering chart: \"managed-pg\" as .manifests/${RELEASE_NAME}/managed-pg"
  assert_line "wrote .tmp/${RELEASE_NAME}/managed-pg/templates/job-create-db-user.yml"
  assert_success

  JOB_ID="job.batch/${RELEASE_NAME}-managed-pg-create-db-user"

  run helm just apply "${RELEASE_NAME}" -l app=create-db-user
  assert_output "${JOB_ID} created"
  assert_success

  run kubectl wait --for=condition=failed --timeout=20s "${JOB_ID}"
  echo "" >&2
  echo "After kubectl wait --for=condition=failed --timeout=20s" >&2
  echo "$ kubectl logs ${JOB_ID}" >&2
  kubectl logs "${JOB_ID}" >&2
  refute_output "${JOB_ID} condition met"
  assert_failure

  run kubectl wait --for=condition=complete --timeout=2m "${JOB_ID}"
  echo "" >&2
  echo "After kubectl wait --for=condition=complete --timeout=2m" >&2
  echo "$ kubectl logs ${JOB_ID}" >&2
  kubectl logs "${JOB_ID}" >&2
  assert_output "${JOB_ID} condition met"
  assert_success
}
