#!/bin/bash
_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
RELEASE_VERSION=v1.1.0
curl -LO https://github.com/operator-framework/operator-sdk/releases/download/${RELEASE_VERSION}/operator-sdk-${RELEASE_VERSION}-x86_64-linux-gnu
curl -LO https://github.com/operator-framework/operator-sdk/releases/download/${RELEASE_VERSION}/ansible-operator-${RELEASE_VERSION}-x86_64-linux-gnu
curl -LO https://github.com/operator-framework/operator-sdk/releases/download/${RELEASE_VERSION}/helm-operator-${RELEASE_VERSION}-x86_64-linux-gnu
chmod +x operator-sdk-${RELEASE_VERSION}-x86_64-linux-gnu && sudo mkdir -p ~/bin/ && sudo cp operator-sdk-${RELEASE_VERSION}-x86_64-linux-gnu ~/bin/operator-sdk && rm operator-sdk-${RELEASE_VERSION}-x86_64-linux-gnu
chmod +x ansible-operator-${RELEASE_VERSION}-x86_64-linux-gnu && sudo mkdir -p ~/bin/ && sudo cp ansible-operator-${RELEASE_VERSION}-x86_64-linux-gnu ~/bin/ansible-operator && rm ansible-operator-${RELEASE_VERSION}-x86_64-linux-gnu
chmod +x helm-operator-${RELEASE_VERSION}-x86_64-linux-gnu && sudo mkdir -p ~/bin/ && sudo cp helm-operator-${RELEASE_VERSION}-x86_64-linux-gnu ~/bin/helm-operator && rm helm-operator-${RELEASE_VERSION}-x86_64-linux-gnu
