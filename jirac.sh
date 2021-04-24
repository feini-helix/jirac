#!/usr/bin/bash
set -e
. ".jirac"

function create_jira()
{

    local title=$1
    local tmpfile=$(mktemp /tmp/jira-input.XXX)
    local content="${Template//TITLE/$title}"
    echo ${content}  > ${tmpfile}
    curl --request POST \
         --url "${BaseURL}/rest/api/3/issue" \
         --user "${Email}:${APIToken}" \
         --header 'Accept: application/json' \
         --header 'Content-Type: application/json' \
         -d @${tmpfile}
    # To print a newline
    echo
}

while IFS= read -r line; do
    [[ $line =~ ^#.* ]] && continue
    create_jira "${line}"
    done
