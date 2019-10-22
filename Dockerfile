FROM sergioguillen/debian-systemd-base:stretch
LABEL maintainer=serguimant@gmail.com

# Password: administrator:administrator
# mkpasswd -S sg -s <<< administrator
ENV ADMIN_PASSWORD=sgFBHGvF4NroU
RUN useradd administrator -d "/home/administrator" -m -s /bin/bash -G sudo -p ${ADMIN_PASSWORD}}

RUN apt update \
    && apt install -y \
        openssh-server vim git less file \
        tmux htop curl wget dnsutils python net-tools sudo \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD ["/sbin/init"]
