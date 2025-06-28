# Jupyter notebook environment with ML libraries
FROM python:3.11-slim AS base

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    vim \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Main stage
FROM base AS main

WORKDIR /workspace

# Install Jupyter and common ML libraries
RUN pip install --no-cache-dir \
    jupyter \
    jupyterlab \
    numpy \
    pandas \
    matplotlib \
    seaborn \
    scikit-learn \
    plotly \
    bokeh \
    ipywidgets \
    jupyterlab-git

# Install additional data science libraries
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Create non-root user
RUN groupadd -r jupyter && useradd -r -g jupyter jupyter

# Create directories
RUN mkdir -p /workspace/notebooks /workspace/data /workspace/models && \
    chown -R jupyter:jupyter /workspace

# Copy notebook templates
COPY notebooks/ /workspace/notebooks/
RUN chown -R jupyter:jupyter /workspace/notebooks

# Switch to non-root user
USER jupyter

# Copy Jupyter configuration
COPY jupyter_notebook_config.py /home/jupyter/.jupyter/

EXPOSE 8888

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
    CMD curl -f http://localhost:8888/api || exit 1

# Start Jupyter Lab
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
