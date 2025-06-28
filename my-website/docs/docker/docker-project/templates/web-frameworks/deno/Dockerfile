# Multi-stage build for Deno application
FROM denoland/deno:1.37.0 AS base

WORKDIR /app

# Development stage
FROM base AS development

# Copy source code
COPY . .

# Cache dependencies
RUN deno cache --unstable main.ts

EXPOSE 8000

CMD ["deno", "run", "--allow-net", "--allow-read", "--allow-env", "--watch", "main.ts"]

# Production stage
FROM base AS production

# Create non-root user
RUN groupadd -r deno && useradd -r -g deno deno

WORKDIR /app

# Copy source code
COPY --chown=deno:deno . .

# Cache dependencies
RUN deno cache --unstable main.ts

USER deno

EXPOSE 8000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:8000/health || exit 1

CMD ["deno", "run", "--allow-net", "--allow-read", "--allow-env", "main.ts"]
