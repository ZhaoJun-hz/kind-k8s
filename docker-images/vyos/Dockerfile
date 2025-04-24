FROM my.harbor.cn/vyos/vyos:vyos-1.5-rolling-202504180226

RUN echo "deb https://mirrors.tuna.tsinghua.edu.cn/debian-security bookworm-security main contrib non-free" > /etc/apt/sources.list.d/debian-bookworm.list

RUN apt-get -y update >/dev/null && apt-get -y install \
    lrzsz >/dev/null 2>&1
