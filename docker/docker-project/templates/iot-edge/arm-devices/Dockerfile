# ARM-based IoT device application
FROM arm64v8/alpine:latest AS base

# Install system dependencies
RUN apk add --no-cache \
    curl \
    python3 \
    py3-pip \
    gpio-utils \
    i2c-tools

# Development stage
FROM base AS development

WORKDIR /app

# Install Python dependencies
COPY requirements-dev.txt .
RUN pip3 install --no-cache-dir -r requirements-dev.txt

# Copy source code
COPY . .

# Development command
CMD ["python3", "app.py", "--debug"]

# Production stage
FROM base AS production

# Create non-root user
RUN addgroup -g 1001 -S iot && \
    adduser -S iot -u 1001 -G iot

WORKDIR /app

# Install production dependencies
COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt

# Copy application files
COPY --chown=iot:iot . .

# Switch to non-root user
USER iot

# Health check
HEALTHCHECK --interval=60s --timeout=10s --start-period=10s --retries=3 \
    CMD python3 health_check.py || exit 1

# Run IoT application
CMD ["python3", "app.py"]
