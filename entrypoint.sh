#! /usr/bin/env bash
set -e 

printf "TCPKeepAlive yes\nStrictModes no\nPermitTunnel yes\nPermitUserEnvironment yes" > /etc/ssh/sshd_config

exec "$@"