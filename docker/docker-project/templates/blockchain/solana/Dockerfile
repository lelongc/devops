# Solana program development environment
FROM ubuntu:22.04 AS base

# Prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    build-essential \
    pkg-config \
    libudev-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Development stage
FROM base AS development

# Install Solana CLI
RUN sh -c "$(curl -sSfL https://release.solana.com/stable/install)"
ENV PATH="/root/.local/share/solana/install/active_release/bin:${PATH}"

# Install Anchor framework
RUN cargo install --git https://github.com/coral-xyz/anchor avm --locked --force
RUN avm install latest && avm use latest

WORKDIR /app

# Copy Cargo files
COPY Cargo.toml ./

# Install dependencies
RUN cargo fetch

# Copy source code
COPY . .

EXPOSE 8899 8900

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
    CMD solana cluster-version || exit 1

# Start local validator
CMD ["solana-test-validator"]

# Build stage
FROM development AS builder

# Build Solana program
RUN anchor build

# Production stage
FROM alpine AS production

# Copy built program
COPY --from=builder /app/target/deploy /deploy

VOLUME ["/deploy"]

CMD ["sh", "-c", "echo 'Solana program artifacts available in /deploy'"]
