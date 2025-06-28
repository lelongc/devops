# MLflow tracking and model serving
FROM python:3.11-slim AS base

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Main stage
FROM base AS main

WORKDIR /mlflow

# Install MLflow and dependencies
RUN pip install --no-cache-dir \
    mlflow \
    boto3 \
    azure-storage-blob \
    google-cloud-storage \
    psycopg2-binary \
    pymysql

# Copy MLflow configuration
COPY mlflow.ini /mlflow/mlflow.ini

# Create non-root user
RUN groupadd -r mlflow && useradd -r -g mlflow mlflow

# Create directories
RUN mkdir -p /mlflow/artifacts /mlflow/db && \
    chown -R mlflow:mlflow /mlflow

# Copy initialization scripts
COPY scripts/ /usr/local/bin/
RUN chmod +x /usr/local/bin/*.sh

USER mlflow

EXPOSE 5000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
    CMD curl -f http://localhost:5000/health || exit 1

# Start MLflow server
CMD ["mlflow", "server", \
     "--host", "0.0.0.0", \
     "--port", "5000", \
     "--backend-store-uri", "sqlite:///mlflow/db/mlflow.db", \
     "--default-artifact-root", "/mlflow/artifacts"]
