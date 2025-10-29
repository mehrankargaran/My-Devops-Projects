terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5.1"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2.2"
    }
  }
}

# Create Bash script for installing and configuring Nginx
resource "local_file" "install_nginx_script" {
  content = <<EOT
#!/bin/bash
set -e

echo "🚀 Starting Nginx installation..."

# Remove default Apache if exists
if systemctl list-units --type=service | grep -q apache2; then
  echo "🧹 Removing Apache to avoid conflict..."
  sudo systemctl stop apache2 || true
  sudo apt remove -y apache2 || true
fi

# Install Nginx
sudo apt update -y
sudo apt install -y nginx

# Create custom web directory
sudo mkdir -p /var/www/kargaran_nginx
sudo chown -R www-data:www-data /var/www/kargaran_nginx
sudo chmod -R 755 /var/www/kargaran_nginx

# Create custom HTML page
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

# Configure Nginx server block
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

# Enable new configuration
sudo ln -sf /etc/nginx/sites-available/kargaran.conf /etc/nginx/sites-enabled/
sudo rm -f /etc/nginx/sites-enabled/default

# Restart Nginx
sudo systemctl restart nginx
sudo systemctl enable nginx

# Verify
if sudo ss -tuln | grep -q 8080; then
  echo "✅ Nginx is running on port 8080 with custom site."
else
  echo "⚠️ Failed to start Nginx on port 8080."
fi

echo "🎯 Deployment finished successfully."
EOT

  filename = "${path.module}/install_nginx.sh"
  file_permission = "0755"
}

# Execute the script
resource "null_resource" "execute_nginx_install" {
  provisioner "local-exec" {
    command = "bash ${path.module}/install_nginx.sh | tee ${path.module}/nginx_status.txt"
  }

  depends_on = [local_file.install_nginx_script]
}

output "nginx_status" {
  value = "Custom Nginx site deployed successfully! Check nginx_status.txt for details."
}
