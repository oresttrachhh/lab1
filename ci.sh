#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

echo "Running Maven tests..."
mvn --batch-mode clean test

echo "Building executable JAR..."
mvn --batch-mode package

jar_file="build/hello.jar"
if [[ ! -f "$jar_file" ]]; then
  echo "ERROR: ${jar_file} was not produced." >&2
  exit 1
fi

echo "Verifying ${jar_file}..."
java -jar "$jar_file"
