#!/bin/bash
_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd ~/git/ammosquared/web-platform

timestamp=$(date +"%H%M%S")
testfile="/tmp/ammosq-test-$timestamp.txt"
echo "RSpec output file: $testfile"

DBUSER=postgres \
DBHOST="db.lb.legion.kotawerks.gg" \
DBPASSWORD="$ADMIN_DB_PASSWD" \
DISABLE_SPRING=true \
RAILS_ENV=test \
time bundle exec rspec \
  --exclude-pattern "spec/system/**/*" \
  --format documentation \
  --format progress \
  --out $testfile
