FROM ubuntu:jammy

ENV DEBIAN_FRONTEND=noninteractive

# Setup apt-fast and upgrade packages
RUN apt-get update \
    && apt-get install -y gnupg aria2 software-properties-common \
    && apt-key adv --keyserver keyserver.ubuntu.com \
                   --recv-keys A2166B8DE8BDC3367D1901C11EE2FF37CA8DA16B \
    && add-apt-repository ppa:apt-fast/stable -y \
    && apt-get install -y apt-fast \
    && echo debconf apt-fast/maxdownloads string 512 | debconf-set-selections \
    && echo debconf apt-fast/dlflag boolean true | debconf-set-selections \
    && echo debconf apt-fast/aptmanager string apt-get | debconf-set-selections \
    && apt-fast dist-upgrade -y 

# Setup SSH
RUN apt-get install -y openssh-server
COPY files/sshd_config /etc/ssh/sshd_config

# Add User
RUN adduser sevralt --gecos '' --disabled-password

# Install dependencies
RUN apt-fast install -y \
    clang build-essential nano git bc bison coreutils ccache curl flex \
    g++-multilib gcc-multilib git gnupg gperf imagemagick lib32ncurses5-dev \ 
    lib32readline-dev lib32z1-dev liblz4-tool vim libncurses5 libncurses5-dev \
    libsdl1.2-dev curl libssl-dev libxml2 libxml2-utils lzop pngcrush rsync \
    schedtool squashfs-tools xsltproc zip zlib1g-dev manpages man-db tmux

# Copy default environment variables
COPY files/environment /etc/environment

# Setup entrypoint
COPY files/entrypoint.sh /usr/local/sbin/entrypoint.sh
RUN chmod +x /usr/local/sbin/entrypoint.sh

EXPOSE 22

VOLUME [ "/home/sevralt", "/root" ]

ENTRYPOINT [ "/bin/bash" ]
CMD [ "/usr/local/sbin/entrypoint.sh" ]