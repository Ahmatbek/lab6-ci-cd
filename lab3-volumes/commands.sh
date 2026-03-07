#!/bin/bash

echo "--- Step 1: Creating Docker Volume ---"
docker volume create postgres-lab-data [cite: 458]

echo "--- Step 2: Starting PostgreSQL Container (Port 5433) ---"
docker run -d \
  --name postgres-lab \
  --mount source=postgres-lab-data,target=/var/lib/postgresql/data \
  -e POSTGRES_USER=student \
  -e POSTGRES_PASSWORD=student123 \
  -e POSTGRES_DB=university \
  -p 5433:5432 \
  postgres:15-alpine [cite: 460-467]

echo "Waiting for database to start..."
sleep 5

echo "--- Step 3: Importing Initial Data ---"
docker exec -i postgres-lab psql -U student -d university < init.sql [cite: 500]

echo "--- Step 4: Verifying Data ---"
docker exec -it postgres-lab psql -U student -d university -c "SELECT * FROM students;" [cite: 502-503]

echo "--- Step 5: Testing Persistence (Removing Container) ---"
docker rm -f postgres-lab [cite: 511]

echo "--- Step 6: Restarting with Same Volume ---"
docker run -d \
  --name postgres-lab-2 \
  --mount source=postgres-lab-data,target=/var/lib/postgresql/data \
  -e POSTGRES_USER=student \
  -e POSTGRES_PASSWORD=student123 \
  -p 5433:5432 \
  postgres:15-alpine [cite: 516-522]

echo "--- Step 7: Final Data Verification ---"
docker exec -it postgres-lab-2 psql -U student -d university -c "SELECT * FROM students;" [cite: 524]

echo "--- Step 8: Creating Backups ---"
# Logical Backup [cite: 529]
docker exec postgres-lab-2 pg_dump -U student university > backup.sql
# Volume Archive [cite: 532-536]
docker run --rm --mount source=postgres-lab-data,target=/data -v $(pwd):/backup ubuntu tar czf /backup/postgres-volume-backup.tar.gz /data

echo "Lab 3 Completed Successfully!"
