# Unity game development and build environment
FROM ubuntu:22.04 AS base

# Prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    wget \
    unzip \
    xvfb \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    && rm -rf /var/lib/apt/lists/*

# Development stage with Unity Editor
FROM base AS development

# Install Unity Hub
RUN wget -qO - https://hub.unity3d.com/linux/keys/public | apt-key add - && \
    echo 'deb https://hub.unity3d.com/linux/repos/deb stable main' | tee /etc/apt/sources.list.d/unityhub.list && \
    apt-get update && \
    apt-get install -y unityhub

# Set Unity environment
ENV UNITY_PATH="/opt/unity/editors"
ENV PATH="$PATH:$UNITY_PATH"

WORKDIR /project

# Copy Unity project files
COPY . .

# Expose Unity Editor port (for remote development)
EXPOSE 54321

# Start Unity Hub
CMD ["unityhub"]

# Build stage
FROM base AS builder

# Install Unity Editor (headless)
ARG UNITY_VERSION=2023.1.0f1
ENV UNITY_PATH="/opt/unity/editors/$UNITY_VERSION"

RUN mkdir -p $UNITY_PATH && \
    wget -O unity-editor.tar.xz "https://download.unity3d.com/download_unity/builds/$UNITY_VERSION/LinuxEditorInstaller/Unity.tar.xz" && \
    tar -xf unity-editor.tar.xz -C $UNITY_PATH --strip-components=1 && \
    rm unity-editor.tar.xz

WORKDIR /project

# Copy Unity project
COPY . .

# Build the game
RUN xvfb-run --auto-servernum --server-args='-screen 0 1024x768x24' \
    $UNITY_PATH/Unity \
    -batchmode \
    -quit \
    -projectPath /project \
    -buildTarget StandaloneLinux64 \
    -buildPath /builds/game

# Production stage for web builds
FROM nginx:alpine AS web-production

# Copy built WebGL game
COPY --from=builder /builds/WebGL /usr/share/nginx/html

# Copy nginx configuration for Unity WebGL
COPY nginx-webgl.conf /etc/nginx/conf.d/default.conf

# Create non-root user
RUN addgroup -g 1001 -S unity && \
    adduser -S unity -u 1001 -G unity

# Set permissions
RUN chown -R unity:unity /usr/share/nginx/html && \
    chown -R unity:unity /var/cache/nginx && \
    chown -R unity:unity /var/log/nginx

USER unity

EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD curl -f http://localhost/ || exit 1

CMD ["nginx", "-g", "daemon off;"]

# Artifacts stage for desktop builds
FROM alpine AS desktop-artifacts

# Copy built desktop game
COPY --from=builder /builds/game /game

VOLUME ["/game"]

CMD ["sh", "-c", "echo 'Game artifacts available in /game'"]
