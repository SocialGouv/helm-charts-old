#!/usr/bin/env bats

load /usr/lib/bats-support/load.bash
load /usr/lib/bats-assert/load.bash

export JUST_CHARTS_DIRECTORY="charts"

HASHED=$CI_COMMIT_SHORT_SHA
RELEASE_NAME=${RELEASE_NAME:="migrate-test-${HASHED}"}

setup() {
  helm just delete "${RELEASE_NAME}" -l app=migrate || true
}

teardown() {
  helm just delete "${RELEASE_NAME}" -l app=migrate || true
}

@test "should migrate a database" {
  run helm just render "${RELEASE_NAME}" managed-pg \
    --set db.name="db_${HASHED}" \
    --set db.password="pass_${HASHED}" \
    --set db.user="user_${HASHED}" \
    --set migrate.command=psql -d db_${HASHED} -c "CREATE TABLE test_migration (id serial PRIMARY KEY)" \
    # --set migrate.args[0]="-d" \
    # --set migrate.args[1]="db_${HASHED}" \
    # --set migrate.args[2]="-c" \
    # --set migrate.args[3]="CREATE TABLE test_migration (id serial PRIMARY KEY)" \
    --set migrate.image="postgres:11.5-alpine" \

  assert_line "Rendering chart: \"managed-pg\" as .manifests/${RELEASE_NAME}/managed-pg"
  assert_line "wrote .tmp/${RELEASE_NAME}/managed-pg/templates/job-migrate.yml"
  assert_success

  run helm just apply "${RELEASE_NAME}" -l app=migrate
  assert_output "job.batch/${RELEASE_NAME}-managed-pg-migrate created"
  assert_success

  run kubectl wait --for=condition=failed --timeout=20s "job.batch/${RELEASE_NAME}-managed-pg-migrate"
  echo "" >&2
  echo "After kubectl wait --for=condition=failed --timeout=20s" >&2
  echo "$ kubectl logs job.batch/${RELEASE_NAME}-managed-pg-migrate" >&2
  kubectl logs "job.batch/${RELEASE_NAME}-managed-pg-migrate" >&2
  refute_output "job.batch/${RELEASE_NAME}-managed-pg-migrate condition met"
  assert_failure

  run kubectl wait --for=condition=complete --timeout=2m "job.batch/${RELEASE_NAME}-managed-pg-migrate"
  echo "" >&2
  echo "After kubectl wait --for=condition=complete --timeout=2m" >&2
  echo "$ kubectl logs job.batch/${RELEASE_NAME}-managed-pg-migrate" >&2
  kubectl logs "job.batch/${RELEASE_NAME}-managed-pg-migrate" >&2
  assert_output "job.batch/${RELEASE_NAME}-managed-pg-migrate condition met"
  assert_success
}
