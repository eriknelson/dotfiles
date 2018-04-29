#!/bin/bash
_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

google-chrome-stable -new-window \
  kubernetes.slack.com \
  openservicebrokerapi.slack.com \
  gophers.slack.com \
  coreos.slack.com
