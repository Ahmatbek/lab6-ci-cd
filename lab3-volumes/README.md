# Laboratory Work #3: PostgreSQL with Persistent Storage

## Goal
The objective of this lab is to create a PostgreSQL database using Docker volumes to ensure data persists even after the container is deleted[cite: 442].

## Project Structure [cite: 451-454]
* `init.sql`: SQL script to initialize tables and seed data.
* `commands.sh`: Shell script containing all Docker CLI commands.
* `backup.sql`: Logical database backup.
* `postgres-volume-backup.tar.gz`: Physical backup of the Docker volume.

## Key Concepts Used
1. **Docker Volumes**: Used for persistent storage managed by Docker[cite: 23, 37].
2. **Mounting**: Attaching the volume to the container's data directory (`/var/lib/postgresql/data`)[cite: 26, 61].
3. **Data Persistence**: Demonstrating that data remains available after `docker rm -f` by re-mounting the volume to a new container[cite: 30, 92].

## How to Run
1. Ensure Docker is running on your Mac.
2. Execute the command script:
   ```bash
   ./commands.sh
   ```
3. Verify the existence of `backup.sql` and the compressed volume archive.

## Evaluation Criteria [cite: 538]
* Volume creation and connection (20 pts)
* Container stability (15 pts)
* Table initialization (20 pts)
* Persistence verification (25 pts)
* Successful backups (10 pts)
