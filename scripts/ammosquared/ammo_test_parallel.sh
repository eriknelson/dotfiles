#!/bin/bash
_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $AMMOSQ_MAIN

timestamp=$(date +"%H%M%S")
testfile="/tmp/ammosq-test-$timestamp.txt"
echo "RSpec output file: $testfile"

export DBUSER=postgres
export DBHOST="db.lb.legion.kotawerks.gg"
export DBPASSWORD="$ADMIN_DB_PASSWD"
export DISABLE_SPRING=true
export RAILS_ENV=test

time bundle exec rake parallel:spec
