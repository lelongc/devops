# Multi-stage build for PyTorch application
FROM pytorch/pytorch:2.0.1-cuda11.7-cudnn8-runtime AS base

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    vim \
    && rm -rf /var/lib/apt/lists/*

# Development stage
FROM base AS development

WORKDIR /app

# Install development dependencies
COPY requirements-dev.txt .
RUN pip install --no-cache-dir -r requirements-dev.txt

# Install Jupyter for development
RUN pip install jupyter jupyterlab tensorboard

# Copy source code
COPY . .

EXPOSE 8888 6006 8000

# Jupyter command for development
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]

# Training stage
FROM base AS training

WORKDIR /app

# Install training dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy training scripts
COPY . .

# Create directories for data and models
RUN mkdir -p /app/data /app/models /app/logs

VOLUME ["/app/data", "/app/models", "/app/logs"]

# Training command
CMD ["python", "train.py"]

# Inference/Production stage
FROM base AS production

# Create non-root user
RUN groupadd -r mluser && useradd -r -g mluser mluser

WORKDIR /app

# Install production dependencies
COPY requirements-prod.txt .
RUN pip install --no-cache-dir -r requirements-prod.txt

# Copy application files
COPY --chown=mluser:mluser . .

# Copy pre-trained model (if available)
COPY --chown=mluser:mluser models/ ./models/

# Switch to non-root user
USER mluser

EXPOSE 8000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
    CMD curl -f http://localhost:8000/health || exit 1

# Run inference server
CMD ["python", "serve.py"]
