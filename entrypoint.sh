#! /usr/bin/env bash
set -e 

mkdir -p /home/spectrapulse
bindfs --force-user=spectrapulse \
       --force-group=spectrapulse \
       --create-for-user=1000 \
       --create-for-group=1000 \
       --chown-ignore \
       --chgrp-ignore \
       /mnt/spectrapulse \
       /home/spectrapulse

mkdir -p /home/sevralt
bindfs --force-user=sevralt \
       --force-group=sevralt \
       --create-for-user=1001 \
       --create-for-group=1001 \
       --chown-ignore \
       --chgrp-ignore \
       /mnt/sevralt \
       /home/sevralt

yes | cp -rf /sshd_config /etc/ssh/sshd_config

exec "$@"