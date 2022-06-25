#! /bin/bash

chown -R sevralt:sevralt /home/sevralt

if [ ! -d "/root/.cfg" ]; then
  HD=/root
  
  git clone --bare https://github.com/spectrapulse/dotfiles $HD/.cfg
  /usr/bin/git --git-dir=$HD/.cfg/ --work-tree=$HD checkout -f master

  echo "" >> $HD/.config/starship.toml
  echo "[container]" >> $HD/.config/starship.toml
  echo "disabled = true" >> $HD/.config/starship.toml
  echo "" >> $HD/.config/starship.toml
  echo "[hostname]" >> $HD/.config/starship.toml
  echo "disabled = true" >> $HD/.config/starship.toml
fi 

if [ ! -d "/sevralt/.cfg" ]; then
  HD=/home/sevralt
  
  git clone --bare https://github.com/spectrapulse/dotfiles $HD/.cfg
  /usr/bin/git --git-dir=$HD/.cfg/ --work-tree=$HD checkout -f master
  
  echo "" >> $HD/.config/starship.toml
  echo "[container]" >> $HD/.config/starship.toml
  echo "disabled = true" >> $HD/.config/starship.toml
  echo "" >> $HD/.config/starship.toml
  echo "[hostname]" >> $HD/.config/starship.toml
  echo "disabled = true" >> $HD/.config/starship.toml
  echo "" >> $HD/.config/starship.toml
fi 

mkdir -p /var/run/sshd

/usr/sbin/sshd -D
