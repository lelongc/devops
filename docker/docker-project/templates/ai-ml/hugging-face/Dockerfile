# Hugging Face Transformers application
FROM python:3.11-slim AS base

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Development stage
FROM base AS development

WORKDIR /app

# Install development dependencies
COPY requirements-dev.txt .
RUN pip install --no-cache-dir -r requirements-dev.txt

# Install Hugging Face libraries
RUN pip install --no-cache-dir \
    transformers \
    datasets \
    tokenizers \
    accelerate \
    gradio \
    streamlit

# Copy source code
COPY . .

EXPOSE 7860 8501

# Gradio app for development
CMD ["python", "app.py"]

# Production stage
FROM base AS production

# Create non-root user
RUN groupadd -r huggingface && useradd -r -g huggingface huggingface

WORKDIR /app

# Install production dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application files
COPY --chown=huggingface:huggingface . .

# Download and cache models
RUN python -c "from transformers import AutoTokenizer, AutoModel; AutoTokenizer.from_pretrained('bert-base-uncased'); AutoModel.from_pretrained('bert-base-uncased')"

# Switch to non-root user
USER huggingface

EXPOSE 8000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD curl -f http://localhost:8000/health || exit 1

# Run inference server
CMD ["python", "serve.py"]
