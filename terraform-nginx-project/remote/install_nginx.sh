#!/bin/bash
set -e

# مسیر وب‌سایت
sudo mkdir -p /var/www/kargaran_nginx

# ایجاد فایل HTML سفارشی
sudo bash -c 'cat > /var/www/kargaran_nginx/index.html <<EOF
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>Welcome | Kargaran Engineering Company</title>
    <style>
      body { background-color: #f8f9fa; text-align: center; margin-top: 100px; font-family: Arial; }
      h1 { color: green; }
      p { font-size: 18px; color: #333; }
    </style>
  </head>
  <body>
    <h1>✅ Welcome to Nginx powered by <strong>Kargaran Engineering Company</strong></h1>
    <p>🚀 Successfully deployed using Terraform</p>
  </body>
</html>
EOF'

# پیکربندی Nginx برای پورت 8080
sudo bash -c 'cat > /etc/nginx/sites-available/kargaran.conf <<EOF
server {
    listen 8080;
    server_name _;
    root /var/www/kargaran_nginx;
    index index.html;
    location / {
        try_files \$uri \$uri/ =404;
    }
}
EOF'

# فعال‌سازی سایت و حذف پیش‌فرض
sudo ln -sf /etc/nginx/sites-available/kargaran.conf /etc/nginx/sites-enabled/
sudo rm -f /etc/nginx/sites-enabled/default

# راه‌اندازی مجدد Nginx
sudo systemctl restart nginx
sudo systemctl enable nginx

# بررسی پورت
if sudo ss -tuln | grep -q 8080; then
  echo "✅ Nginx is running on port 8080 with custom site."
else
  echo "⚠️ Failed to start Nginx on port 8080."
fi

echo "🎯 Deployment finished successfully."
