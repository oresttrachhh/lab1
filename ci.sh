#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

echo "Running Maven tests..."
mvn --batch-mode clean test

echo "Building executable JAR..."
mvn --batch-mode package

jar_file="$(find target -maxdepth 1 -type f -name 'HelloProject-*.jar' | head -n 1)"
if [[ -z "$jar_file" ]]; then
  echo "ERROR: No HelloProject JAR was produced." >&2
  exit 1
fi

echo "Verifying ${jar_file}..."
java -jar "$jar_file"
