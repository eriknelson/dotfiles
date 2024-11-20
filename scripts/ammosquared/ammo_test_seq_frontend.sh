#!/bin/bash
_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
pushd $AMMOSQ_MAIN
eval "$(direnv export zsh)"

#timestamp=$(date +"%H%M%S")
#testfile="/tmp/ammosq-test-$timestamp.txt"
#echo "RSpec output file: $testfile"

# NOTE: When specifying the "spec/system/**/*" glob format here, it's actually
# important to wrap this in quotation marks, because if you don't do that, it
# will actually use shell expansion, and in my case, that means zsh.
time bundle exec rspec \
  --format documentation \
  -P "spec/system/signin*"
  #-P "spec/system/signin*_spec.rb"
  #"spec/system/**/*"
