# Lab 4: Environment Variables & Configuration

This project demonstrates how to build a containerized Flask application that uses environment variables for configuration. It follows the "12-Factor App" methodology by separating code from configuration.

## Key Features
* **Environment Validation**: The app validates required secrets at startup to prevent runtime crashes.
* **Security**: Sensitive data is managed via `.env` files and strictly excluded from Git history.
* **Dual Environments**: Support for both local development (host-to-container) and isolated production networks (container-to-container).
* **Non-Root Execution**: The Docker image runs as a non-privileged user (`appuser`) to follow security best practices.

---

## 🛠 Prerequisites
* Docker Desktop
* A running PostgreSQL instance (from Lab 3)

---

## 🚀 How to Run (Development Mode)
Use this mode to connect the Dockerized app to a database running on your host machine (Mac).

1. **Prepare Environment File**:
   ```bash
   cp .env.example .env.development
   # Ensure .env.development has:
   # DB_HOST=host.docker.internal
   # DB_PORT=5433
   ```

2. **Build and Run**:
   ```bash
   docker build -t config-app .
   docker run -d \
     --name config-app-dev \
     --env-file .env.development \
     -p 5001:5000 \
     config-app
   ```

3. **Verify**:
   Visit [http://localhost:5001/](http://localhost:5001/) or [http://localhost:5001/db-test](http://localhost:5001/db-test).

---

## 🔐 How to Run (Production-Ready Mode)
Use this mode for complete architectural isolation using Docker Networks.

1. **Create an Isolated Network**:
   ```bash
   docker network create lab4-net
   ```

2. **Launch Database (Hidden from Host)**:
   ```bash
   docker run -d --name lab4-db --network lab4-net \
     -e POSTGRES_USER=produser \
     -e POSTGRES_PASSWORD=prodpass123 \
     -e POSTGRES_DB=proddb \
     postgres:15-alpine
   ```

3. **Launch App**:
   ```bash
   docker run -d --name lab4-app-prod --network lab4-net \
     --env-file .env.production \
     -p 5002:5000 \
     config-app
   ```

4. **Verify**:
   Visit [http://localhost:5002/db-test](http://localhost:5002/db-test).

---

## 📁 Project Structure
* `app.py`: Flask application with `/` and `/db-test` routes.
* `config.py`: Configuration class with environment variable validation logic.
* `Dockerfile`: Secure, non-root Python environment.
* `.env.example`: Template for required configuration variables.
* `.gitignore`: Prevents secrets from being committed to the repository.
