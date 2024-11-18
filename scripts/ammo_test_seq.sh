#!/bin/bash
_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $NSK_GIT_DIR/ammosquared/web-platform

DBUSER=postgres \
DBHOST="db.lb.legion.kotawerks.gg" \
DBPASSWORD="$ADMIN_DB_PASSWD" \
DISABLE_SPRING=true \
RAILS_ENV=test \
bundle exec bundle exec rspec --exclude-pattern "spec/system/**/*"
