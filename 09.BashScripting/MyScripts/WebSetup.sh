#!/bin/bash

# Перевірка наявності аргументів командного рядка
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <template_name.zip> <template_url> <destination_folder>"
    exit 1
fi

# Змінні
template_name="$1"
template_url="$2"
destination_folder="$3"

# Визначення типу операційної системи
if [ -f /etc/os-release ]; then
    source /etc/os-release
    OS="$ID"
elif [ -f /etc/centos-release ]; then
    OS="centos"
else
    echo "Unsupported operating system."
    exit 1
fi

# Оновлення ОС
if [ "$OS" == "ubuntu" ]; then
    sudo apt update
    sudo apt upgrade -y
elif [ "$OS" == "centos" ]; then
    sudo dnf update -y
else
    echo "Unsupported operating system."
    exit 1
fi

# Встановлення Apache (httpd)
if [ "$OS" == "ubuntu" ]; then
    sudo apt install apache2 -y
elif [ "$OS" == "centos" ]; then
    sudo dnf install httpd -y
else
    echo "Unsupported operating system."
    exit 1
fi

# Завантаження темплейту та розархівація його
wget -O "$template_name" "$template_url"
sudo apt install unzip -y || sudo dnf install unzip -y
unzip "$template_name" -d "$destination_folder"

# Перезапуск служби Apache (httpd)
if [ "$OS" == "ubuntu" ]; then
    sudo systemctl restart apache2
elif [ "$OS" == "centos" ]; then
    sudo systemctl restart httpd
else
    echo "Unsupported operating system."
    exit 1
fi
