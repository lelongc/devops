# Multi-stage build for Django application
FROM python:3.11-slim AS base

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Dependencies stage
FROM base AS dependencies
WORKDIR /app
COPY requirements*.txt ./
RUN pip install --user -r requirements.txt

# Development stage
FROM base AS development
WORKDIR /app
ENV DJANGO_SETTINGS_MODULE=myproject.settings.development
COPY requirements*.txt ./
RUN pip install -r requirements.txt
COPY . .
EXPOSE 8000
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

# Production stage
FROM base AS production

# Create non-root user
RUN groupadd -r django && useradd --no-log-init -r -g django django

WORKDIR /app

# Install production dependencies
COPY --from=dependencies /root/.local /home/django/.local

# Copy application
COPY --chown=django:django . .

# Set environment
ENV PATH="/home/django/.local/bin:${PATH}" \
    DJANGO_SETTINGS_MODULE=myproject.settings.production

# Switch to non-root user
USER django

# Collect static files
RUN python manage.py collectstatic --noinput

EXPOSE 8000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:8000/health/ || exit 1

# Use gunicorn for production
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "--workers", "4", "myproject.wsgi:application"]
