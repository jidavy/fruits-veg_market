#!/bin/bash

# Variables passed from Jenkins
WEB_IP=$1
PYTHON_IP=$2
JAVA_IP=$3

echo "--- Starting Smoke Test ---"

# 1. Check Frontend (Nginx)
if curl -s --head  http://$WEB_IP | grep "200 OK" > /dev/null; then
    echo "✅ Frontend is UP"
else
    echo "❌ Frontend is DOWN"
    exit 1
fi

# 2. Check Python Backend (FastAPI)
if curl -s http://$PYTHON_IP:8080/fruits | grep "name" > /dev/null; then
    echo "✅ Python API is UP"
else
    echo "❌ Python API is DOWN"
    exit 1
fi

# 3. Check Java Backend (Spring Boot)
if curl -s http://$JAVA_IP:9090/vegetables | grep "name" > /dev/null; then
    echo "✅ Java API is UP"
else
    echo "❌ Java API is DOWN"
    exit 1
fi

echo "--- All Systems Go! ---"
