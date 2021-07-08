#!/bin/bash
_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

NAME=ernelson0707a
ZONE=wdc04
FLAVOR=m3c.4x32
WORKERS="3"
VERSION="4.7.16_openshift"

ibmcloud oc cluster create classic \
  --zone=$ZONE \
  --flavor=$FLAVOR \
  --workers=$WORKERS \
  --name=$NAME \
  --version=$VERSION \
  --public-service-endpoint
