export BZ_LIMIT=500

_bzdump() {
  totalquery="$1&limit=$BZ_LIMIT"
  curl -skL "$totalquery" \
    -H "Authorization: Bearer $BZ_API_KEY" \
    | jq -r '.bugs[] | "[\(.status)] [\(.assigned_to)] \(.summary) (https://bugzilla.redhat.com/show_bug.cgi?id=\(.id))"'
}

_rawbzdump() {
  totalquery="$1&limit=$BZ_LIMIT"
  curl -skL "$totalquery" \
    -H "Authorization: Bearer $BZ_API_KEY" \
    | jq -r '.bugs[] | select(.component[0] != "Documentation") | "[\(.component|first)] [\(.status)] [\(.assigned_to)] \(.summary) (https://bugzilla.redhat.com/show_bug.cgi?id=\(.id))"'
}

_rawbz() {
  queryUrl="https://bugzilla.redhat.com/rest/bug/$1"
  curl -skL "${queryUrl}"
}

bzt() {
  queryUrl="https://bugzilla.redhat.com/rest/bug"
  queryUrl="${queryUrl}?product=Migration%20Toolkit%20for%20Containers"
  queryUrl="${queryUrl}&bug_status=NEW"
  queryUrl="${queryUrl}&bug_status=ASSIGNED"

  _rawbzdump $queryUrl
}

bzq() {
  if [[ "$1" == "" ]]; then
    echo "ERROR: Must pass release as first argument"
    echo "Ex: bzq 1.4.z"
    return
  fi

  queryUrl="https://bugzilla.redhat.com/rest/bug"
  queryUrl="${queryUrl}?product=Migration%20Toolkit%20for%20Containers"
  queryUrl="${queryUrl}&bug_status=NEW"
  queryUrl="${queryUrl}&bug_status=ASSIGNED"
  queryUrl="${queryUrl}&bug_status=POST"
  queryUrl="${queryUrl}&bug_status=MODIFIED"
  queryUrl="${queryUrl}&bug_status=ON_DEV"
  queryUrl="${queryUrl}&bug_status=ON_QA"
  queryUrl="${queryUrl}&bug_status=VERIFIED"
  queryUrl="${queryUrl}&bug_status=RELEASE_PENDING"
  queryUrl="${queryUrl}&bug_status=CLOSED"
  queryUrl="${queryUrl}&target_release=$1"

  _rawbzdump $queryUrl
}

bzna() {
  if [[ "$1" == "" ]]; then
    echo "ERROR: Must pass release as first argument"
    echo "Ex: bzq 1.4.z"
    return
  fi

  queryUrl="https://bugzilla.redhat.com/rest/bug"
  queryUrl="${queryUrl}?product=Migration%20Toolkit%20for%20Containers"
  queryUrl="${queryUrl}&bug_status=NEW"
  queryUrl="${queryUrl}&bug_status=ASSIGNED"
  queryUrl="${queryUrl}&target_release=$1"

  _rawbzdump $queryUrl
}

bznac() {
  if [[ "$1" == "" ]]; then
    echo "ERROR: Must pass release as first argument"
    echo "Ex: bzq 1.4.z"
    return
  fi
  bzna $1 \
    | perl -ne '/\[.*?\] \[.*?\] \[(.*?)\]/ && print "$1\n"' \
    | sort | uniq -c
}

bztypecount() {
  if [[ "$1" == "" ]]; then
    echo "ERROR: Must pass release as first argument"
    echo "Ex: bzq 1.4.z"
    return
  fi
  bzq $1 \
    | perl -ne '/\[(.*?)\] \[.*?\]/ && print "$1\n"' \
    | sort | uniq -c
}
