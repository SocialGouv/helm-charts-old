#!/usr/bin/env bats

load /usr/lib/bats-support/load.bash
load /usr/lib/bats-assert/load.bash

export JUST_CHARTS_DIRECTORY="charts"

HASHED=$CI_COMMIT_SHORT_SHA
RELEASE_NAME=${RELEASE_NAME:="seed-test-${HASHED}"}

setup() {
  helm just delete "${RELEASE_NAME}" -l app=seed || true
}

teardown() {
  helm just delete "${RELEASE_NAME}" -l app=seed || true
}

@test "should seed a database" {
  run helm just render "${RELEASE_NAME}" managed-pg \
    --set db.name="db_${HASHED}" \
    --set db.password="pass_${HASHED}" \
    --set db.user="user_${HASHED}" \
    --set seed.command=psql \
    --set seed.args[0]="-d" \
    --set seed.args[1]="db_${HASHED}" \
    --set seed.args[2]="-c" \
    --set seed.args[3]="INSERT INTO test_migration VALUES(42);" \
    --set seed.image="postgres:11.5-alpine"

  assert_line "Rendering chart: \"managed-pg\" as .manifests/${RELEASE_NAME}/managed-pg"
  assert_line "wrote .tmp/${RELEASE_NAME}/managed-pg/templates/job-seed.yml"
  assert_success

  run helm just apply "${RELEASE_NAME}" -l app=seed
  assert_output "job.batch/${RELEASE_NAME}-managed-pg-seed created"
  assert_success

  run kubectl wait --for=condition=failed --timeout=20s "job.batch/${RELEASE_NAME}-managed-pg-seed"
  echo "" >&2
  echo "After kubectl wait --for=condition=failed --timeout=20s" >&2
  echo "$ kubectl logs job.batch/${RELEASE_NAME}-managed-pg-seed" >&2
  kubectl logs "job.batch/${RELEASE_NAME}-managed-pg-seed" >&2
  refute_output "job.batch/${RELEASE_NAME}-managed-pg-seed condition met"
  assert_failure

  run kubectl wait --for=condition=complete --timeout=2m "job.batch/${RELEASE_NAME}-managed-pg-seed"
  echo "" >&2
  echo "After kubectl wait --for=condition=complete --timeout=2m" >&2
  echo "$ kubectl logs job.batch/${RELEASE_NAME}-managed-pg-seed" >&2
  kubectl logs "job.batch/${RELEASE_NAME}-managed-pg-seed" >&2
  assert_output "job.batch/${RELEASE_NAME}-managed-pg-seed condition met"
  assert_success
}
