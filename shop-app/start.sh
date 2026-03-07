#!/bin/bash

docker network create shop-network

docker run -d \
--name redis \
--network shop-network \
redis:7-alpine

cd backend
docker build -t shop-backend .

docker run -d \
--name backend \
--network shop-network \
-p 5001:5000 \
shop-backend

cd ..

cd frontend
docker build -t shop-frontend .

docker run -d \
--name frontend \
--network shop-network \
-p 8080:80 \
shop-frontend

cd ..

echo "Shop running!"
echo "Frontend: http://localhost:8080"
echo "API: http://localhost:5001/products"
