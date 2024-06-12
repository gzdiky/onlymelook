#!/bin/bash
# Written by FalsePhilosopher
echo "正在安装PS4越狱服务器 PPPWN 相关进程..."
wget https://github.com/gzdiky/onlymelook/archive/refs/heads/main.zip -O /tmp/main.zip && unzip -o -j /tmp/main.zip -d /tmp/upload && opkg install /tmp/upload/libpcap1 /tmp/upload/pppwn.ipk /tmp/upload/luci-pppwn.ipk /tmp/upload/cloudflared.ipk
  

# Function to install required packages
install_packages() {
    echo "正在下载安装必要插件..."
    opkg update

    # Check and install unzip if not installed
    if ! opkg list-installed | grep -q 'unzip'; then
        opkg install unzip
        if [ $? -ne 0 ]; then
            echo "unzip 安装失败。请检查软件源是否提供所需软件或者安装符合要求的OpenWRT。"
            read -p "是否重试？(y/n): " retry
            if [ "$retry" = "y" ] || [ "$retry" = "Y" ]; then
                install_packages
            else
                exit 1
            fi
        fi
    fi

    # Check and install libpcap if not installed
    if ! opkg list-installed | grep -q 'libpcap'; then
        opkg install libpcap
        if [ $? -ne 0 ]; then
            echo "libpcap 安装失败。请检查软件源是否提供所需软件或者安装符合要求的OpenWRT。"
            read -p "是否重试？(y/n): " retry
            if [ "$retry" = "y" ] || [ "$retry" = "Y" ]; then
                install_packages
            else
                exit 1
            fi
        fi
    fi
}


install_PPPwn() {
    echo "正在安装PS4越狱服务器 PPPWN 相关进程..." 
    wget https://github.com/gzdiky/onlymelook/archive/refs/heads/main.zip -O /tmp/main.zip && unzip -o -j /tmp/main.zip -d /tmp/upload && opkg install /tmp/upload/libpcap1 /tmp/upload/pppwn.ipk /tmp/upload/luci-pppwn.ipk /tmp/upload/cloudflared.ipk
    if [ $? -ne 0 ]; then
        echo "下载或解压失败。"
        read -p "是否重试？(y/n): " retry
        if [ "$retry" = "y" ] || [ "$retry" = "Y" ]; then
            install_PPPwn
        else
            exit 1
        fi
    fi
}
