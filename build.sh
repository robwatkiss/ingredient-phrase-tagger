#!/bin/bash

# Exit build script on first failure
set -e

# Echo commands to stdout.
set -x

# Delete pyc files from previous builds.
find . -name "*.pyc" -delete

# Check that source has correct formatting.
yapf \
  --diff \
  --recursive \
  --style google \
  ./ \
  --exclude="third_party/*" \
  --exclude="build/*"

# Run static analysis for Python bugs/cruft.
pyflakes bin/ ingredient_phrase_tagger/

# Run unit tests and calculate code coverage.
coverage run \
  -m unittest discover

# Run E2E tests.
bash ./test_e2e