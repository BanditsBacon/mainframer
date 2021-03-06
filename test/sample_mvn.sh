#!/bin/bash
set -e

# You can run it from any directory.
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Execute common pre-setup, include test functions.
# shellcheck disable=SC1090
source "$DIR/common.sh"

printTestStarted

# Copy Maven sample to build dir.
cp -a "$DIR/../samples/mvn/." "$BUILD_DIR"

# Overwrite config to work with test remote machine.
setTestRemoteMachineInConfig

# Run mainframer that builds Maven project.
"$MAINFRAMER_EXECUTABLE" './mvnw clean package'

# Run jar to ensure that it was built fine.
java -jar "$BUILD_DIR/target/sample-1.0.jar"

printTestEnded
