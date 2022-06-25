FROM ubuntu:jammy

LABEL org.opencontainers.image.description="Development Container for @SevralT"
LABEL org.opencontainers.image.version="0.1.0"

ENV DEBIAN_FRONTEND=noninteractive

# Update package index and upgrade packages
RUN apt-get update \
    && apt-get dist-upgrade -y 

# Setup SSH
RUN apt-get install -y openssh-server
COPY files/sshd_config /etc/ssh/sshd_config

# Add User
RUN adduser sevralt --gecos '' --disabled-password

# Install dependencies
RUN apt-get install -y \
    clang build-essential nano git bc bison coreutils ccache curl flex \
    g++-multilib gcc-multilib git gnupg gperf imagemagick lib32ncurses5-dev \ 
    lib32readline-dev lib32z1-dev liblz4-tool vim libncurses5 libncurses5-dev \
    libsdl1.2-dev curl libssl-dev libxml2 libxml2-utils lzop pngcrush rsync \
    schedtool squashfs-tools xsltproc zip zlib1g-dev manpages man-db tmux gnupg aria2

# Copy default environment variables
COPY files/environment /etc/environment

# Install starship
RUN wget -O /tmp/starship-install.sh https://starship.rs/install.sh \
    && chmod +x /tmp/starship-install.sh \
    && /tmp/starship-install.sh --force \
    && rm -f /tmp/starship-install.sh

# Setup entrypoint
COPY files/entrypoint.sh /usr/local/sbin/entrypoint.sh
RUN chmod +x /usr/local/sbin/entrypoint.sh

EXPOSE 22

VOLUME [ "/home/sevralt", "/root" ]

ENTRYPOINT [ "/bin/bash" ]
CMD [ "/usr/local/sbin/entrypoint.sh" ]
