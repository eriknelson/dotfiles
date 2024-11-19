#!/bin/bash
_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $AMMOSQ_MAIN

timestamp=$(date +"%H%M%S")
testfile="/tmp/ammosq-test-$timestamp.txt"
echo "RSpec output file: $testfile"

bundle exec rake parallel:create
bundle exec rake parallel:setup
bundle exec rake parallel:prepare
