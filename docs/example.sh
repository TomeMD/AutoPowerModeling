#!/bin/bash

export REPO_DIR=`cd $(dirname $(dirname "$0")); pwd`

TRAIN_TIMESTAMPS_DIR="${REPO_DIR}"/log/train
TEST_TIMESTAMPS_DIR="${REPO_DIR}"/log/test
RESULTS_DIR="${REPO_DIR}"/log/results

mkdir -p "${TRAIN_TIMESTAMPS_DIR}"
mkdir -p "${TEST_TIMESTAMPS_DIR}"
mkdir -p "${RESULTS_DIR}"

# Get train timestamps
./CPUPowerWatcher/run.sh -w stress-system -b public -v apptainer -o "${TRAIN_TIMESTAMPS_DIR}"

# Copy all train timestamps into a single file
cat "${TRAIN_TIMESTAMPS_DIR}"/*.timestamps > "${TRAIN_TIMESTAMPS_DIR}"/all_train.timestamps
TRAIN_FILE="${TRAIN_TIMESTAMPS_DIR}"/all_train.timestamps

# Some time to rest between workload executions
sleep 300

# Get test timestamps
./CPUPowerWatcher/run.sh -w npb -b public -v apptainer -o "${TEST_TIMESTAMPS_DIR}"

# Set a list of test files
TEST_FILES=""
for TEST_FILE in $(find "${TEST_TIMESTAMPS_DIR}" -name "*.timestamps"); do
  if [ -n "${TEST_FILES}" ]; then
    TEST_FILES="${TEST_FILES},${TEST_FILE}"
  else
    TEST_FILES+="${TEST_FILE}"
  fi
done

# Automatically build a model using a second-degree polynomial regression from the previous collected metrics
powerseer -n example_model -b public -t "${TRAIN_FILE}" -a "${TEST_FILES}" -p polynomial --vars user_load,system_load,freq -o "${RESULTS_DIR}"