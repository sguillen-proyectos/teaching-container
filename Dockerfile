# This needs to be run as a privileged container
FROM debian:stretch-backports
LABEL maintainer=serguimant@gmail.com

ENV container docker
ENV LC_ALL C
ENV DEBIAN_FRONTEND noninteractive

# Password: administrator:administrator
# mkpasswd -S sg -s <<< administrator
ENV ADMIN_PASSWORD=sgFBHGvF4NroU
RUN useradd administrator -d "/home/administrator" -m -s /bin/bash -G sudo -p ${ADMIN_PASSWORD}}

RUN apt-get update \
    && apt-get install -y \
        systemd \
        lsb-release apt-utils cron at rsyslog \
        initscripts libsystemd0 libudev1 sysvinit-utils udev util-linux \
        openssh-server \
        sudo less vim git htop \
    && apt-get clean \
    && sed -i '/imklog/{s/^/#/}' /etc/rsyslog.conf \
    && mkdir -p /var/run/sshd /run/sshd \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && rm -f /lib/systemd/system/multi-user.target.wants/* \
        /etc/systemd/system/*.wants/* \
        /lib/systemd/system/local-fs.target.wants/* \
        /lib/systemd/system/sockets.target.wants/*udev* \
        /lib/systemd/system/sockets.target.wants/*initctl* \
        /lib/systemd/system/sysinit.target.wants/systemd-tmpfiles-setup* \
        /lib/systemd/system/systemd-update-utmp* \
    && systemctl set-default multi-user.target

VOLUME [ "/sys/fs/cgroup" ]

CMD ["/lib/systemd/systemd"]
