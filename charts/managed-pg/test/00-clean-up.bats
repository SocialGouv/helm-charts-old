#!/usr/bin/env bats

load test_helper

@test "/!\ : Reset database with 30-drop-db-user.bats test" {
  run bats "${BATS_TEST_DIRNAME}/30-drop-db-user.bats"
}
