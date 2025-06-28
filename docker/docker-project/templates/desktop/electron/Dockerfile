# Electron application build environment
FROM node:18-alpine AS base

# Install system dependencies for Electron
RUN apk add --no-cache \
    git \
    python3 \
    make \
    g++ \
    libx11-dev \
    libxkbfile-dev \
    libsecret-dev

# Development stage
FROM base AS development

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm ci

# Copy source code
COPY . .

# Start Electron in development mode
CMD ["npm", "run", "electron:dev"]

# Build stage
FROM base AS builder

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install all dependencies
RUN npm ci

# Copy source code
COPY . .

# Build the application
RUN npm run build

# Build Electron distributables
RUN npm run electron:build

# Production stage (for web version)
FROM nginx:alpine AS web-production

# Install curl for health checks
RUN apk add --no-cache curl

# Copy built web application
COPY --from=builder /app/dist /usr/share/nginx/html

# Copy nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Create non-root user
RUN addgroup -g 1001 -S electron && \
    adduser -S electron -u 1001 -G electron

# Set permissions
RUN chown -R electron:electron /usr/share/nginx/html && \
    chown -R electron:electron /var/cache/nginx && \
    chown -R electron:electron /var/log/nginx

USER electron

EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD curl -f http://localhost/ || exit 1

CMD ["nginx", "-g", "daemon off;"]

# Packaging stage (for desktop distributables)
FROM alpine AS desktop-artifacts

# Copy built desktop applications
COPY --from=builder /app/dist-electron /dist-electron

# This stage contains the built desktop applications
# Artifacts can be extracted with: docker cp container:/dist-electron ./
VOLUME ["/dist-electron"]

CMD ["sh", "-c", "echo 'Desktop artifacts available in /dist-electron'"]
