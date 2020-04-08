#!/usr/bin/env bats

load test_helper

test_job "seed"

setup_all() {
  helm just delete "${RELEASE_NAME}" -l app="${TEST_JOB}" || true
  helm just test delete "${RELEASE_NAME}" -l app="test-${TEST_JOB}" || true
}

teardown_all() {
  helm just delete "${RELEASE_NAME}" -l app="${TEST_JOB}" || true
  helm just test delete "${RELEASE_NAME}" -l app="test-${TEST_JOB}" || true
}

@test "helm just render ${RELEASE_NAME} managed-pg : should render the job-${TEST_JOB}.yaml" {
  run helm just render "${RELEASE_NAME}" managed-pg \
    --set db.name="db_${HASHED}" \
    --set db.password="pass_${HASHED}" \
    --set db.user="user_${HASHED}" \
    --set seed.args="{-d,db_${HASHED},-c,INSERT INTO test_migration VALUES(42);}" \
    --set seed.command=psql \
    --set seed.image="postgres:11.5-alpine"

  assert_line "Rendering chart: \"managed-pg\" as .manifests/${RELEASE_NAME}/managed-pg"
  assert_line "wrote .tmp/${RELEASE_NAME}/managed-pg/templates/job-${TEST_JOB}.yaml"
  assert_success
}

@test "helm just apply ${RELEASE_NAME} -l app=${TEST_JOB} : should create the ${JOB_ID}" {
  run helm just apply "${RELEASE_NAME}" -l app="${TEST_JOB}"
  assert_output "${JOB_ID} created"
  assert_success
}

@test "${JOB_ID} : should be successful" {
  job_success
}

@test "helm just test apply ${RELEASE_NAME} -l app=${TEST_JOB} : should create the ${TEST_JOB_ID}" {
  run helm just test apply "${RELEASE_NAME}" -l app="test-${TEST_JOB}"
  assert_output "${TEST_JOB_ID} created"
  assert_success
}

@test "${JOB_ID} : should seed the db_${HASHED} database by inserting 42" {
  job_success
}
