# Godot game development and build environment
FROM ubuntu:22.04 AS base

# Prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    xvfb \
    libglu1-mesa \
    && rm -rf /var/lib/apt/lists/*

# Development stage
FROM base AS development

# Install Godot
ARG GODOT_VERSION=4.1.1
RUN wget https://downloads.tuxfamily.org/godotengine/$GODOT_VERSION/Godot_v${GODOT_VERSION}-stable_linux.x86_64.zip && \
    unzip Godot_v${GODOT_VERSION}-stable_linux.x86_64.zip && \
    mv Godot_v${GODOT_VERSION}-stable_linux.x86_64 /usr/local/bin/godot && \
    chmod +x /usr/local/bin/godot && \
    rm Godot_v${GODOT_VERSION}-stable_linux.x86_64.zip

WORKDIR /project

# Copy Godot project
COPY . .

EXPOSE 6007

# Start Godot editor
CMD ["godot", "--editor"]

# Build stage
FROM development AS builder

# Export game for web
RUN mkdir -p /builds/web && \
    xvfb-run --auto-servernum --server-args='-screen 0 1024x768x24' \
    godot --export "HTML5" /builds/web/index.html

# Export game for desktop
RUN mkdir -p /builds/desktop && \
    xvfb-run --auto-servernum --server-args='-screen 0 1024x768x24' \
    godot --export "Linux/X11" /builds/desktop/game

# Web production stage
FROM nginx:alpine AS web-production

# Copy built web game
COPY --from=builder /builds/web /usr/share/nginx/html

# Copy nginx configuration
COPY nginx-godot.conf /etc/nginx/conf.d/default.conf

# Create non-root user
RUN addgroup -g 1001 -S godot && \
    adduser -S godot -u 1001 -G godot

# Set permissions
RUN chown -R godot:godot /usr/share/nginx/html && \
    chown -R godot:godot /var/cache/nginx && \
    chown -R godot:godot /var/log/nginx

USER godot

EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD curl -f http://localhost/ || exit 1

CMD ["nginx", "-g", "daemon off;"]

# Desktop artifacts stage
FROM alpine AS desktop-artifacts

# Copy built desktop game
COPY --from=builder /builds/desktop /game

VOLUME ["/game"]

CMD ["sh", "-c", "echo 'Godot game artifacts available in /game'"]
