# Bài 3: Cài đặt Nginx và cấu hình Website tĩnh cơ bản (Basic Nginx Web Server)

## 🎯 1. Mục Tiêu
- Cài đặt dịch vụ Web Server Nginx trên hệ điều hành Ubuntu Server thông qua trình quản lý gói `apt`.
- Thiết lập một Server Block tùy chỉnh lắng nghe trên cổng mặc định HTTP (80) để phục vụ trang HTML tĩnh của dự án PTIT.

---

## 📋 2. Yêu Cầu Chi Tiết (Requirements)
- **Bối cảnh**: Dựng một website giới thiệu đơn giản cho PTIT chạy trên máy chủ Droplet vừa tạo để người dùng ngoài internet truy cập qua IP của máy chủ.
- **Ràng buộc**:
  1. Cài đặt phiên bản Nginx mới nhất từ repository mặc định của Ubuntu (`sudo apt update && sudo apt install nginx -y`).
  2. Tạo thư mục chứa mã nguồn tĩnh tại đường dẫn `/var/www/ptit-web/html/`.
  3. Tạo file `index.html` hiển thị dòng chữ: `Welcome to PTIT DevOps Course - Session 02`.
  4. Tạo file cấu hình Server Block riêng biệt tại `/etc/nginx/sites-available/ptit-web.conf` cấu hình lắng nghe cổng 80, trỏ root về `/var/www/ptit-web/html/`.
  5. Kích hoạt Server Block bằng liên kết tượng trưng (symlink) sang `/etc/nginx/sites-enabled/`.
  6. Xóa hoặc hủy kích hoạt cấu hình trang mặc định `default` của Nginx để tránh xung đột cổng 80.

---

## 🛠️ 3. Hướng Dẫn Các Bước Thực Hiện (Step-by-Step Guide)

### Bước 1: Cài đặt Nginx Web Server
```bash
sudo apt update
sudo apt install nginx -y
```

### Bước 2: Tạo Thư Mục Web Root và File HTML
```bash
sudo mkdir -p /var/www/ptit-web/html
sudo chown -R $USER:$USER /var/www/ptit-web/html
sudo chmod -R 755 /var/www/ptit-web
```

Tạo file `/var/www/ptit-web/html/index.html`:
```html
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>PTIT DevOps Course</title>
</head>
<body>
    <h1>Welcome to PTIT DevOps Course - Session 02</h1>
</body>
</html>
```

### Bước 3: Tạo File Cấu Hình Server Block Nginx
Tạo file `/etc/nginx/sites-available/ptit-web.conf`:
```nginx
server {
    listen 80 default_server;
    listen [::]:80 default_server;

    server_name _;

    root /var/www/ptit-web/html;
    index index.html index.htm;

    location / {
        try_files $uri $uri/ =404;
    }
}
```

### Bước 4: Kích Hoạt Server Block & Hủy Trang Default
```bash
# Kích hoạt ptit-web
sudo ln -sf /etc/nginx/sites-available/ptit-web.conf /etc/nginx/sites-enabled/

# Hủy trang mặc định default
sudo rm -f /etc/nginx/sites-enabled/default
```

### Bước 5: Kiểm Tra Cú Pháp & Reload Nginx
```bash
sudo nginx -t
sudo systemctl reload nginx
```

---

## ✅ 4. Lệnh Kiểm Tra & Kết Quả Mong Đợi (Verification)
- **Kiểm tra cú pháp Nginx**:
  ```bash
  sudo nginx -t
  ```
  *Kết quả mong đợi*: `nginx: configuration file /etc/nginx/nginx.conf syntax is ok`
- **Truy cập từ trình duyệt hoặc lệnh curl**:
  ```bash
  curl http://<IP_ADDRESS_DROPLET>
  ```
  *Kết quả mong đợi*: Màn hình trả về nội dung HTML chứa dòng chữ:
  `Welcome to PTIT DevOps Course - Session 02`
