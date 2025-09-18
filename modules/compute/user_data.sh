#!/bin/bash
set -euxo pipefail

# Update and install httpd
dnf -y update || true
dnf -y install httpd

# Simple test page
echo "<h1>Terraform Project — It works!</h1>" > /var/www/html/index.html
echo "<p>Instance: $(hostname)</p>" >> /var/www/html/index.html

# Enable and start httpd
systemctl enable httpd
systemctl start httpd
