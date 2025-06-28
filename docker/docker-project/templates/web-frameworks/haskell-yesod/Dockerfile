# Multi-stage build for Haskell Yesod application
FROM haskell:9.4-alpine AS base

# Install system dependencies
RUN apk add --no-cache \
    zlib-dev \
    postgresql-dev \
    curl

# Development stage
FROM base AS development

WORKDIR /app

# Copy cabal files
COPY *.cabal cabal.project ./

# Install dependencies
RUN cabal update && cabal build --dependencies-only

# Copy source code
COPY . .

EXPOSE 3000

CMD ["cabal", "run"]

# Build stage
FROM base AS builder

WORKDIR /app

# Copy cabal files
COPY *.cabal cabal.project ./

# Copy source and build
COPY . .
RUN cabal update
RUN cabal build
RUN cabal install --install-method=copy --installdir=.

# Production stage
FROM alpine:3.18 AS production

# Install runtime dependencies
RUN apk add --no-cache \
    gmp \
    libffi \
    postgresql-client \
    curl

# Create non-root user
RUN addgroup -g 1001 -S yesod && \
    adduser -S yesod -u 1001 -G yesod

WORKDIR /app

# Copy binary
COPY --from=builder --chown=yesod:yesod /app/myapp .

USER yesod

EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
    CMD curl -f http://localhost:3000/health || exit 1

CMD ["./myapp"]
