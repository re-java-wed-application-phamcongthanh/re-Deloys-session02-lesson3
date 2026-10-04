#!/bin/bash
# Script tự động cài đặt và cấu hình Nginx Server Block cho PTIT Web
set -e

echo "=== 1. Cài đặt Nginx ==="
sudo apt update
sudo apt install nginx -y

echo "=== 2. Tạo Web Root Directory ==="
sudo mkdir -p /var/www/ptit-web/html
sudo cp index.html /var/www/ptit-web/html/index.html
sudo chown -R www-data:www-data /var/www/ptit-web
sudo chmod -R 755 /var/www/ptit-web

echo "=== 3. Cấu hình Nginx Server Block ==="
sudo cp ptit-web.conf /etc/nginx/sites-available/ptit-web.conf
sudo ln -sf /etc/nginx/sites-available/ptit-web.conf /etc/nginx/sites-enabled/
sudo rm -f /etc/nginx/sites-enabled/default

echo "=== 4. Kiểm tra cấu hình và Reload Nginx ==="
sudo nginx -t
sudo systemctl reload nginx

echo "=== CÀI ĐẶT THÀNH CÔNG! Web server sẵn sàng tại port 80 ==="
