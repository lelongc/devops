# Tauri application development and build environment
FROM ubuntu:22.04 AS base

# Prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    build-essential \
    pkg-config \
    libssl-dev \
    libgtk-3-dev \
    libayatana-appindicator3-dev \
    librsvg2-dev \
    libwebkit2gtk-4.0-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs

# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Development stage
FROM base AS development

WORKDIR /app

# Install Tauri CLI
RUN cargo install tauri-cli

# Copy package files
COPY package*.json ./
COPY src-tauri/Cargo.toml src-tauri/Cargo.lock src-tauri/

# Install dependencies
RUN npm ci
RUN cd src-tauri && cargo fetch

# Copy source code
COPY . .

# Development command
CMD ["npm", "run", "tauri", "dev"]

# Build stage
FROM development AS builder

# Build the application
RUN npm run tauri build

# Artifacts stage
FROM alpine AS desktop-artifacts

# Copy built applications
COPY --from=builder /app/src-tauri/target/release/bundle /bundle

VOLUME ["/bundle"]

CMD ["sh", "-c", "echo 'Tauri application bundles available in /bundle'"]
