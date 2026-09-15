#!/bin/bash
# setup-frontend.sh
# Run on a Tier 1 (frontend) node: installs HTTPD, clones the repo, and wires
# index.html to point at this AZ's matching backend node.
# Usage: ./setup-frontend.sh <backend-public-dns>
#   e.g. ./setup-frontend.sh ec2-XX-XXX-XXX-XX.eu-west-2.compute.amazonaws.com

set -e

if [ -z "$1" ]; then
  echo "Usage: $0 <backend-public-dns>"
  exit 1
fi
BACKEND_DNS="$1"

echo "== Installing HTTPD and git =="
sudo yum install httpd -y
sudo systemctl start httpd
sudo systemctl enable httpd
sudo yum install git -y

echo "== Cloning repo =="
cd ~
if [ ! -d "fruits-veg_market" ]; then
  git clone https://github.com/jidavy/fruits-veg_market.git
fi
cd fruits-veg_market/web

echo "== Wiring index.html to backend: $BACKEND_DNS =="
sed -i "s/FRUIT_MACHINE/${BACKEND_DNS}/g" index.html
sed -i "s/VEG_MACHINE/${BACKEND_DNS}/g" index.html

echo "== Deploying to /var/www/html =="
sudo cp index.html /var/www/html/

echo "Frontend node setup complete. Visit this node's public IP to verify."
