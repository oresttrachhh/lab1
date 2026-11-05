#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

echo "Running Maven tests..."
if ! mvn --batch-mode clean test; then
  echo "ERROR: Maven tests failed." >&2
  exit 1
fi

echo "Building executable JAR..."
if ! mvn --batch-mode package; then
  echo "ERROR: Maven package failed." >&2
  exit 1
fi

jar_file="build/hello.jar"
if [[ ! -f "$jar_file" ]]; then
  echo "ERROR: ${jar_file} was not produced." >&2
  exit 1
fi

echo "Verifying ${jar_file}..."
if ! java -jar "$jar_file"; then
  echo "ERROR: ${jar_file} could not be executed." >&2
  exit 1
fi

echo "SUCCESS: tests passed and ${jar_file} was created."
