FROM kindest/node:v1.31.4

RUN echo "Types: deb\n\
URIs: http://mirrors.aliyun.com/debian\n\
Suites: bookworm bookworm-updates\n\
Components: main\n\
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg\n\
\n\
Types: deb\n\
URIs: http://mirrors.aliyun.com/debian-security\n\
Suites: bookworm-security\n\
Components: main\n\
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg" > /etc/apt/sources.list.d/debian.sources

RUN apt-get -y update >/dev/null && apt-get -y install \
    iputils-ping \
    bash \
    sed \
    curl \
    wget \
    strace \
    netcat-openbsd \
    busybox \
    iproute2 \
    mtr \
    arping \
    apache2-utils \
    net-tools \
    iptables \
    ipset \
    ethtool \
    tmux \
    tcpdump \
    tcpflow \
    tshark \
    ipvsadm \
    openssl \
    vim \
    iperf \
    iperf3 \
    nmap \
    tini \
    scapy \
    bird \
    openrc \
    dnsutils \
    telnet \
    lrzsz >/dev/null 2>&1
