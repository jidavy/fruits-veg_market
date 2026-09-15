#!/bin/bash
# setup-backend.sh
# Run on a Tier 2 (backend) node: installs Python venv + FastAPI service (port 8080)
# and Java/Maven + Spring Boot service (port 9090) for fruits-veg_market.
# Usage: run as ec2-user, from the home directory (~), on Amazon Linux.

set -e

echo "== Installing git, Java 17, Maven =="
sudo yum install git -y
sudo yum install java-17-amazon-corretto -y
sudo yum install maven -y
python3 --version   # confirm Python 3 is present (ships with Amazon Linux)

echo "== Cloning repo =="
cd ~
if [ ! -d "fruits-veg_market" ]; then
  git clone https://github.com/jidavy/fruits-veg_market.git
fi
cd fruits-veg_market

echo "== Setting up Python (fruits) service on :8080 =="
cd python
python3 -m venv .venv
source .venv/bin/activate
python -m pip install -r requirements.txt
deactivate
sudo cp fruits.service /etc/systemd/system/fruits.service
sudo systemctl daemon-reload
sudo systemctl enable --now fruits.service
cd ..

echo "== Building and setting up Java (vegetables) service on :9090 =="
cd java
mvn clean package
sudo cp vegetables.service /etc/systemd/system/vegetables.service
sudo systemctl daemon-reload
sudo systemctl enable --now vegetables.service
cd ..

echo "== Status =="
sudo systemctl status fruits.service --no-pager
sudo systemctl status vegetables.service --no-pager

echo "== Sanity checks =="
curl -s http://localhost:8080/fruits && echo
curl -s http://localhost:9090/vegetables && echo

echo "Backend node setup complete."
