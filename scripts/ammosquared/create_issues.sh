#!/bin/bash
currentProject="Web App and Platform"
currentMilestone="December 2024"

issueDir=$1
gitProjDir=$2

function _verify() {
  if [[ "$issueDir" == "" ]]; then
    echo "ERROR: Must provide root task dir as first arg"
    exit 1
  fi
  if [[ "$gitProjDir" == "" ]]; then
    echo "ERROR: Must provide git proj dir as second arg"
    exit 1
  fi
}

function main() {
  tasks=$(yq '.tasks[]' $issueDir/meta.yml)
  pushd $gitProjDir
  while IFS= read -r task; do
    skip=$(echo "$task" | jq -r '.skip // false')
    if [ "$skip" = "true" ]; then
      continue
    fi

    title=$(echo "$task" | jq -r '.title')
    bodyFile=$(echo "$task" | jq -r '.bodyFile')
    bodyContent=$(cat $bodyFile)
    # Create labels string with proper formatting
    labels=$(echo "$task" | jq -r '.labels | map("-l=\"" + . + "\"") | join(" ")')

    gh issue create \
      --project="${currentProject}" \
      --milestone="${currentMilestone}" \
      ${labels} \
      --title="${title}" \
      --body="${bodyContent}"
  done < <(echo "$tasks" | jq -c '.')
  popd
}

_verify
main
