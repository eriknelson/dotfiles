#!/bin/bash
_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $AMMOSQ_MAIN

timestamp=$(date +"%H%M%S")
testfile="/tmp/ammosq-test-$timestamp.txt"
echo "RSpec output file: $testfile"

time bundle exec rspec \
  --exclude-pattern "spec/system/**/*" \
  --format documentation \
  --format progress \
  --out $testfile