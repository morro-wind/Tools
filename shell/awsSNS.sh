#!/bin/bash
export AWS_ACCESS_KEY_ID=
export AWS_SECRET_ACCESS_KEY=
export AWS_DEFAULT_REGION=
# $1 value {ALERT.SENDTO}
# $2 value {ALERT.SUBJECT}
# $3 value {ALERT.MESSAGE}

to=$1
subject=$2
body=$3

cat <<EOF | aws sns publish --topic-arn $to --message "$body" --subject
"$subject"
EOF

