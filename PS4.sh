#!/bin/sh

# Welcome message

echo "安装PS4越犾 PPPwn  luci openWRT插件 自动一键安装“
read -p "是否继续？(y/n): " continue_script
if [ "$continue_script" != "y" ] && [ "$continue_script" != "Y" ]; then
    echo "退出脚本。"
    exit 0
fi

# Check if required packages and files are already installed
check_installation() {
    if opkg list-installed | grep -q 'unzip' && opkg list-installed | grep -q 'libpcap' then
        return 0
    else
        return 1
    fi
}

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

# Function to download and install PS4 jailbreak tools
install_jailbreak_tools() {
    echo "正在下载安装PS4越狱openWRT插件....."
    wget https://github.com/gzdiky/onlymelook/archive/refs/heads/main.zip -O /tmp/main.zip && unzip -o /tmp/main.zip -d /tmp/upload
    if [ $? -ne 0 ]; then
        echo "下载或解压失败。"
        read -p "是否重试？(y/n): " retry
        if [ "$retry" = "y" ] || [ "$retry" = "Y" ]; then
            install_jailbreak_tools
        else
            exit 1
        fi
    fi
}

# Check if already installed
if check_installation; then
    echo "你似乎安装PS4越狱openWRT插件。"
    read -p "是否升级或重新安装PS4越狱openWRT插件？(y/n): " reinstall
    if [ "$reinstall" != "y" ] && [ "$reinstall" != "Y" ]; then
        read -p "是否直接开始PS4越狱？(y/n): " start_jailbreak
        if [ "$start_jailbreak" != "y" ] && [ "$start_jailbreak" != "Y" ]; then
            echo "退出脚本。"
            exit 0
        fi
    else
        install_packages
        install_jailbreak_tools
    fi
else
    read -p "是否安装PS4越狱openWRT插件？(y/n): " install
    if [ "$install" != "y" ] && [ "$install" != "Y" ]; then
        echo "退出脚本。"
        exit 0
    else
        install_packages
        install_jailbreak_tools
    fi
fi

# Run the jailbreak tool
echo "正在运行PS4越狱openWRT插件..."
# cd /tmp/upload/onlymelook-main
unzip main.zip
cd /tmp/upload/onlymelook-main
opkg update
opkg install libpcap1
opkg install pppwn.ipk
opkg install luci-pppwn.ipk 
echo "PS4越狱openWRT插件成功。"
 
fi
