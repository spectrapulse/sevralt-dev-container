#! /usr/bin/env bash
set -e 

mkdir -p /home/spectrapulse
chown 1000:1000 /home/spectrapulse
bindfs --force-user=spectrapulse \
       --force-group=spectrapulse \
       --create-for-user=1000 \
       --create-for-group=1000 \
       --chown-ignore \
       --chgrp-ignore \
       /mnt/spectrapulse \
       /home/spectrapulse

mkdir -p /home/sevralt
chown 1001:1001 /home/sevralt
bindfs --force-user=sevralt \
       --force-group=sevralt \
       --create-for-user=1001 \
       --create-for-group=1001 \
       --chown-ignore \
       --chgrp-ignore \
       /mnt/sevralt \
       /home/sevralt

printf "TCPKeepAlive yes\nStrictModes no\nPermitTunnel yes\nPermitUserEnvironment yes" > /etc/ssh/sshd_config

exec "$@"