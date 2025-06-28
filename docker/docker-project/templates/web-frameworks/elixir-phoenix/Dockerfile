# Multi-stage build for Elixir Phoenix application
FROM elixir:1.15-alpine AS base

# Install system dependencies
RUN apk add --no-cache \
    build-base \
    git \
    nodejs \
    npm \
    curl

# Install Hex and Rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# Development stage
FROM base AS development

WORKDIR /app

# Copy mix files
COPY mix.exs mix.lock ./

# Install dependencies
RUN mix deps.get

# Copy source code
COPY . .

# Install npm dependencies and compile assets
RUN cd assets && npm ci && npm run deploy && cd ..
RUN mix phx.digest

EXPOSE 4000

CMD ["mix", "phx.server"]

# Build stage
FROM base AS builder

WORKDIR /app

# Set environment
ENV MIX_ENV=prod

# Copy mix files and install dependencies
COPY mix.exs mix.lock ./
RUN mix deps.get --only prod

# Copy source code
COPY . .

# Compile assets
RUN cd assets && npm ci && npm run deploy && cd ..
RUN mix phx.digest

# Compile application
RUN mix compile
RUN mix release

# Production stage
FROM alpine:3.18 AS production

# Install runtime dependencies
RUN apk add --no-cache \
    openssl \
    ncurses-libs \
    curl

# Create non-root user
RUN addgroup -g 1001 -S phoenix && \
    adduser -S phoenix -u 1001 -G phoenix

WORKDIR /app

# Copy release
COPY --from=builder --chown=phoenix:phoenix /app/_build/prod/rel/myapp .

USER phoenix

EXPOSE 4000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
    CMD curl -f http://localhost:4000/health || exit 1

# Set environment
ENV PHX_SERVER=true

CMD ["./bin/myapp", "start"]
