# Multi-stage build for TensorFlow application
FROM tensorflow/tensorflow:2.13.0-gpu AS base

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# Development stage
FROM base AS development

WORKDIR /app

# Install Python packages
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Install Jupyter for development
RUN pip install jupyter jupyterlab

COPY . .

EXPOSE 8888 6006

# Jupyter command for development
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]

# Production stage
FROM base AS production

# Create non-root user
RUN groupadd -r mluser && useradd -r -g mluser mluser

WORKDIR /app

# Install production dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application files
COPY --chown=mluser:mluser . .

# Switch to non-root user
USER mluser

EXPOSE 8000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
    CMD curl -f http://localhost:8000/health || exit 1

# Run the application
CMD ["python", "app.py"]
