#!/usr/bin/env bats

load test_helper

test_job "create-db-user"

setup_all() {
  helm just delete "${RELEASE_NAME}" -l app=${TEST_JOB} || true
}

teardown_all() {
  helm just delete "${RELEASE_NAME}" -l app=${TEST_JOB} || true
}

@test "helm just render "${RELEASE_NAME}" managed-pg : should render the job-${TEST_JOB}.yaml" {
  run helm just render "${RELEASE_NAME}" managed-pg \
    --set db.name="db_${HASHED}" \
    --set db.password="pass_${HASHED}" \
    --set db.user="user_${HASHED}"

  assert_line "Rendering chart: \"managed-pg\" as .manifests/${RELEASE_NAME}/managed-pg"
  assert_line "wrote .tmp/${RELEASE_NAME}/managed-pg/templates/job-${TEST_JOB}.yaml"
  assert_success
}

@test "helm just apply "${RELEASE_NAME}" -l app=${TEST_JOB} : should create the ${JOB_ID}" {
  run helm just apply "${RELEASE_NAME}" -l app=${TEST_JOB}
  assert_output "${JOB_ID} created"
  assert_success
}


@test "${JOB_ID} : should be successful" {
  job_success
}

@test "${JOB_ID} : should create db_${HASHED} database and user_${HASHED} user" {
  # TODO(douglasduteil): write a test that proves
}
