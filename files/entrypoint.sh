#! /bin/bash

chown -R sevralt:sevralt /home/sevralt

mkdir -p /var/run/sshd

/usr/sbin/sshd -D