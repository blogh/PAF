#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

# setup log sink
cat <<'EOF' > /etc/rsyslog.d/log_sink.conf
$ModLoad imtcp 
$InputTCPServerRun 514

$template RemoteLogsMerged,"/var/log/%HOSTNAME%/messages.log"
*.* ?RemoteLogsMerged

$template RemoteLogs,"/var/log/%HOSTNAME%/%PROGRAMNAME%.log"
*.* ?RemoteLogs
#& ~
EOF

systemctl --quiet restart rsyslog
