#!/bin/bash
_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd ~/git/ammosquared/web-platform

timestamp=$(date +"%H%M%S")=
testfile="/tmp/ammosq-test-$timestamp.txt"
echo "RSpec output file: $testfile"

export DBUSER=postgres
export DBHOST="db.lb.legion.kotawerks.gg"
export DBPASSWORD="$ADMIN_DB_PASSWD"
export DISABLE_SPRING=true
export RAILS_ENV=test

bundle exec rake parallel:create
bundle exec rake parallel:setup
bundle exec rake parallel:prepare
