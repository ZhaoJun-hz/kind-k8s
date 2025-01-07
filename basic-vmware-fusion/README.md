## 使用VMWare Fusion 安装 Rocky-9.5
首先配置VMWare Fusion 的网络，后续虚拟机均使用该网络，这里创建的网络为vmnet2，点击左下方+号即可创建，这里设置的子网ip为10.66.66.0/24    
<img alt="01-VMWare Fusion 网络配置.png" src="./image/01-VMWare Fusion 网络配置.png" width="512"/>  
创建虚拟机  
<img alt="02-创建虚拟机1.png" src="./image/02-创建虚拟机1.png" width="512"/>  
选择Rocky-9.5操作系统，点击继续按钮  
<img alt="03-选择操作系统.png" src="./image/03-选择操作系统.png" width="512"/>  
点击自定设置，来进行相关配置  
<img alt="04-自定义设置.png" src="./image/04-自定义设置.png" width="512"/>  
输入虚拟机的名字，点击存储    
<img alt="05-输入虚拟机的名字.png" src="./image/05-输入虚拟机的名字.png" width="512"/>  
点击网络适配器，来配置网络      
<img alt="06-点击网络适配器.png" src="./image/06-点击网络适配器.png" width="512"/>  
选择合适的网络，这里选择vmnet2，即之前配置的网路，点击显示全部按钮，继续配置  
<img alt="07-选择合适的网络.png" src="./image/07-选择合适的网络.png" width="512"/>  
点击硬盘，来配置硬盘大小      
<img alt="08-点击硬盘.png" src="./image/08-点击硬盘.png" width="512"/>  
这里分配100G硬盘空间，这里不是创建完立即就会占用100G空间，而是使用多少占用多少，点击应用按钮，完成配置    
<img alt="09-分配100G大小.png" src="./image/09-分配100G大小.png" width="512"/>  
点击处理器和内存，来分配CPU数量和内存大小        
<img alt="10-点击处理器和内存.png" src="./image/10-点击处理器和内存.png" width="512"/>  
这里分配4个处理器内核 8192MB内存      
<img alt="11-配置4C8G.png" src="./image/11-配置4C8G.png" width="512"/>  
至此，虚拟机配置已经完成，点击播放按钮，开启安装操作系统  
<img alt="12-开始安装操作系统.png" src="./image/12-开始安装操作系统.png" width="512"/>  
使用向上按键 选择Install Rocky Linux 9.5，选中后回车  
<img alt="13-选择Install Rocky Linux 9.5.png" src="./image/13-选择Install Rocky Linux 9.5.png" width="512"/>  
选择简体中文，点击继续  
<img alt="14-选择简体中文.png" src="./image/14-选择简体中文.png" width="512"/>  
点击安装目标位置  
<img alt="15-点击安装目标位置.png" src="./image/15-点击安装目标位置.png" width="512"/>  
这里不做任何配置，直接点完成即可  
<img alt="16-直接点完成即可.png" src="./image/16-直接点完成即可.png" width="512"/>  
点击网络和主机名，来配置网络和主机名  
<img alt="17-点击网络和主机名.png" src="./image/17-点击网络和主机名.png" width="512"/>  
首先输入主机名，这里输入k8sKind，点击应用按钮，完成主机名配置，接着点击右方配置按钮，来配置网络  
<img alt="18-配置主机名.png" src="./image/18-配置主机名.png" width="512"/>  
选择IPv4设置，方法选择手动，输入对应的地址、子网掩码、网关和DNS服务器，点击保存即可，这里之所以手动设置，是希望IP地址固定，方便后续ssh登录等  
<img alt="19-配置网络.png" src="./image/19-配置网络.png" width="512"/>  
点击 完成 按钮，网路和主机名也就配置完成了  
<img alt="20-网络和主机名配置完成.png" src="./image/20-网络和主机名配置完成.png" width="512"/>  
点击设置root密码来配置root用户的密码  
<img alt="21-点击设置root密码.png" src="./image/21-点击设置root密码.png" width="512"/>  
输入两遍同样的密码，勾选允许root用户使用密码进行SSH登录，点击完成  
<img alt="22-root用户密码设置完成.png" src="./image/22-root用户密码设置完成.png" width="512"/>  
创建一个普通用户  
<img alt="23-创建普通用户.png" src="./image/23-创建普通用户.png" width="512"/>  
输入全名、用户名、两遍密码，点击完成  
<img alt="24-创建普通用户完成.png" src="./image/24-创建普通用户完成.png" width="512"/>  
点击开始安装，开始安装  
<img alt="25-点击开始安装.png" src="./image/25-点击开始安装.png" width="512"/>  
当右下角出现重启操作系统时，表示系统已安装完成，此时点击虚拟机 -> CD/DVD -> 断开连接CD/DVD，按图示操作  
接着点击重启系统  
<img alt="26-断开连接CDDVD并重启操作系统.png" src="./image/26-断开连接CDDVD并重启操作系统.png" width="512"/>  









