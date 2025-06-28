# Multi-stage build for Bun application
FROM oven/bun:1 AS base

WORKDIR /app

# Development stage
FROM base AS development

# Copy package files
COPY package.json bun.lockb ./

# Install dependencies
RUN bun install

# Copy source code
COPY . .

EXPOSE 3000

CMD ["bun", "run", "dev"]

# Build stage
FROM development AS builder

# Build the application
RUN bun run build

# Production stage
FROM oven/bun:1-alpine AS production

# Create non-root user
RUN addgroup -g 1001 -S bunuser && \
    adduser -S bunuser -u 1001 -G bunuser

WORKDIR /app

# Copy package files and install production dependencies
COPY package.json bun.lockb ./
RUN bun install --production

# Copy built application
COPY --from=builder --chown=bunuser:bunuser /app/dist ./dist
COPY --from=builder --chown=bunuser:bunuser /app/src ./src

USER bunuser

EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:3000/health || exit 1

CMD ["bun", "run", "start"]
