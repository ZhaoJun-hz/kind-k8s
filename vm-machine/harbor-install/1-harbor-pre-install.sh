#!/bin/bash
date
set -v

# 安装必要依赖
yum -y install lrzsz vim-enhanced
yum install -y yum-utils device-mapper-persistent-data lvm2 wget net-tools nfs-utils lrzsz gcc gcc-c++ make cmake libxml2-devel openssl-devel curl curl-devel unzip sudo libaio-devel vim ncurses-devel autoconf automake zlib-devel epel-release openssh-server socat conntrack telnet ipvsadm

# 关闭 selinux，最后需要重启
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config

# 关闭 firewalld
systemctl stop firewalld && systemctl disable firewalld

# 临时关闭swap 分区
swapoff -a

# 永久关闭 swap 分局
# 定义 fstab 文件路径
FSTAB_FILE="/etc/fstab"
# 注释掉包含 swap 的行
sed -i '/swap/s/^/#/' "$FSTAB_FILE"

# 修改内核参数
modprobe br_netfilter
modprobe ip_vs
modprobe ip_vs_rr
modprobe ip_vs_wrr
modprobe ip_vs_sh
modprobe nf_conntrack
cat > /etc/sysctl.d/k8s.conf << EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF
sysctl -p /etc/sysctl.d/k8s.conf

# 安装container 和 docker 所需要的依赖
yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo

yum install chrony -y
systemctl enable chronyd --now
# 定义要追加的 NTP 服务器
ntp_servers=(
    "server ntp1.aliyun.com iburst"
    "server ntp2.aliyun.com iburst"
    "server ntp1.tencent.com iburst"
    "server ntp2.tencent.com iburst"
)
# 检查并追加 NTP 服务器
for server in "${ntp_servers[@]}"; do
    if ! grep -qx "$server" /etc/chrony.conf; then
        echo "$server" >> /etc/chrony.conf
        echo "Added: $server"
    else
        echo "Already exists: $server"
    fi
done
# 检查并添加定时任务
cron_job="* * * * * /usr/bin/systemctl restart chronyd"
if ! crontab -l | grep -Fxq "$cron_job"; then
    (crontab -l; echo "$cron_job") | crontab -
    echo "Added cron job."
else
    echo "Cron job already exists."
fi
# 重启 crontab 服务
systemctl restart crond
echo "Crontab service restarted."



# 安装docker
yum -y install docker-ce
systemctl start docker && systemctl enable docker.service
tee  /etc/docker/daemon.json << 'EOF'
{
    "registry-mirrors": [
	"https://hub.xdark.top","https://docker.registry.cyou","https://docker-cf.registry.cyou","https://dockerhub.icu","https://docker.unsee.tech","https://hub.geekery.cn"
    ],
    "exec-opts":["native.cgroupdriver=systemd"]
}
EOF
systemctl restart docker
reboot now