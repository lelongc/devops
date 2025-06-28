# Multi-stage build for Rust Actix application
FROM rust:1.70-alpine AS base

# Install build dependencies
RUN apk add --no-cache \
    musl-dev \
    openssl-dev \
    openssl-libs-static \
    pkgconfig

# Development stage
FROM base AS development

WORKDIR /app

# Copy Cargo files
COPY Cargo.toml Cargo.lock ./

# Create dummy source to build dependencies
RUN mkdir src && echo "fn main() {}" > src/main.rs
RUN cargo build --release && rm src/main.rs

# Copy source code
COPY src ./src

EXPOSE 8080

CMD ["cargo", "run"]

# Build stage
FROM base AS builder

WORKDIR /app

# Copy Cargo files
COPY Cargo.toml Cargo.lock ./

# Build dependencies
RUN mkdir src && echo "fn main() {}" > src/main.rs && \
    cargo build --release && \
    rm src/main.rs

# Copy source and build
COPY src ./src
RUN cargo build --release

# Production stage - Use scratch for minimal image
FROM scratch AS production

# Copy ca-certificates
COPY --from=base /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

# Copy the binary
COPY --from=builder /app/target/release/actix-app /actix-app

# Use numeric user ID for scratch
USER 65534:65534

EXPOSE 8080

# Health check (custom implementation required)
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
    CMD ["/actix-app", "--health-check"]

ENTRYPOINT ["/actix-app"]
