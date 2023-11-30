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

# Оновлення CentOS
sudo dnf update -y

# Встановлення Apache (httpd)
sudo dnf install httpd -y

# Завантаження темплейту та розархівація його
wget -O "$template_name" "$template_url"
sudo dnf install unzip -y
unzip "$template_name" -d "$destination_folder"

# Перезапуск сервісу Apache (httpd)
sudo systemctl restart httpd