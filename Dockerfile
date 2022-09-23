FROM ubuntu:jammy

COPY ./entrypoint.sh /

# Install APT-Fast
RUN apt-get update \
 && apt-get install -y gnupg2 \
 && printf "deb http://ppa.launchpad.net/apt-fast/stable/ubuntu jammy main" > /etc/apt/sources.list.d/apt-fast.list \
 && printf "deb-src http://ppa.launchpad.net/apt-fast/stable/ubuntu jammy main" >> /etc/apt/sources.list.d/apt-fast.list \
 && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys A2166B8DE8BDC3367D1901C11EE2FF37CA8DA16B \
 && apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y apt-fast \
 && echo debconf apt-fast/maxdownloads string 32 | debconf-set-selections \
 && echo debconf apt-fast/dlflag boolean true | debconf-set-selections \
 && echo debconf apt-fast/aptmanager string apt-get | debconf-set-selections

# Unminimize image, upgrade packages and install dependencies using APT-Fast
RUN yes | unminimize \
 && DEBIAN_FRONTEND=noninteractive apt-fast full-upgrade -y \
 && DEBIAN_FRONTEND=noninteractive apt-fast install -y \
  openssh-server sudo clang build-essential nano git \bc bison coreutils ccache curl flex \
  g++-multilib gcc-multilib git gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev \
  lib32z1-dev liblz4-tool vim libncurses5 libncurses5-dev libsdl1.2-dev curl libssl-dev libxml2 \
  libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev manpages \
  man-db tmux gnupg aria2 python-is-python3 htop lm-sensors sudo screen

# Setup MISC
RUN printf 'MAKEFLAGS="-j21"' >> /etc/environment \
 && mkdir -p /run/sshd \
 && chmod +x /entrypoint.sh
 

# Create users
RUN adduser spectrapulse --gecos '' --uid 1000 --disabled-password \
 && adduser spectrapulse sudo \
 && adduser sevralt      --gecos '' --uid 1001 --disabled-password 

VOLUME [ "/home/spectrapulse", "/home/sevralt", "/etc/ssh" ]

EXPOSE 22

ENTRYPOINT [ "/entrypoint.sh" ]

CMD [ "/usr/sbin/sshd", "-D", "-e" ]

