#!/usr/bin/env bats

load /usr/lib/bats-support/load.bash
load /usr/lib/bats-assert/load.bash

export JUST_CHARTS_DIRECTORY="charts"

HASHED=$CI_COMMIT_SHORT_SHA
RELEASE_NAME=${RELEASE_NAME:="drop-db-user-test-${HASHED}"}

setup() {
  helm just delete "${RELEASE_NAME}" -l app=drop-db-user || true
}

teardown() {
  helm just delete "${RELEASE_NAME}" -l app=drop-db-user || true
}

@test "should drop a database and a user" {
  run helm just render "${RELEASE_NAME}" managed-pg \
    --set db.name="db_${HASHED}" \
    --set db.password="pass_${HASHED}" \
    --set db.user="user_${HASHED}"

  assert_line "Rendering chart: \"managed-pg\" as .manifests/${RELEASE_NAME}/managed-pg"
  assert_line "wrote .tmp/${RELEASE_NAME}/managed-pg/templates/job-drop-db-user.yaml"
  assert_success

  run helm just apply "${RELEASE_NAME}" -l app=drop-db-user
  assert_output "job.batch/${RELEASE_NAME}-managed-pg-drop-db-user created"
  assert_success

  run kubectl wait --for=condition=failed --timeout=20s "job.batch/${RELEASE_NAME}-managed-pg-drop-db-user"
  echo "" >&2
  echo "After kubectl wait --for=condition=failed --timeout=20s" >&2
  echo "$ kubectl logs job.batch/${RELEASE_NAME}-managed-pg-drop-db-user" >&2
  kubectl logs "job.batch/${RELEASE_NAME}-managed-pg-drop-db-user" >&2
  refute_output "job.batch/${RELEASE_NAME}-managed-pg-drop-db-user condition met"
  assert_failure

  run kubectl wait --for=condition=complete --timeout=2m "job.batch/${RELEASE_NAME}-managed-pg-drop-db-user"
  echo "" >&2
  echo "After kubectl wait --for=condition=complete --timeout=2m" >&2
  echo "$ kubectl logs job.batch/${RELEASE_NAME}-managed-pg-drop-db-user" >&2
  kubectl logs "job.batch/${RELEASE_NAME}-managed-pg-drop-db-user" >&2
  assert_output "job.batch/${RELEASE_NAME}-managed-pg-drop-db-user condition met"
  assert_success
}
