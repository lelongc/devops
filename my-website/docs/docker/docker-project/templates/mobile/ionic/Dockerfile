# Ionic development and build environment
FROM node:18-alpine AS base

# Install system dependencies
RUN apk add --no-cache \
    git \
    python3 \
    make \
    g++

# Development stage
FROM base AS development

WORKDIR /app

# Install Ionic CLI and Capacitor
RUN npm install -g @ionic/cli @capacitor/cli

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm ci

# Copy source code
COPY . .

EXPOSE 8100

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
    CMD curl -f http://localhost:8100 || exit 1

# Start Ionic dev server
CMD ["ionic", "serve", "--host", "0.0.0.0", "--port", "8100"]

# Build stage
FROM development AS builder

# Build for web
RUN ionic build --prod

# Production stage for web
FROM nginx:alpine AS web-production

# Install curl for health checks
RUN apk add --no-cache curl

# Copy built Ionic app
COPY --from=builder /app/www /usr/share/nginx/html

# Copy nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Create non-root user
RUN addgroup -g 1001 -S ionic && \
    adduser -S ionic -u 1001 -G ionic

# Set permissions
RUN chown -R ionic:ionic /usr/share/nginx/html && \
    chown -R ionic:ionic /var/cache/nginx && \
    chown -R ionic:ionic /var/log/nginx

USER ionic

EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD curl -f http://localhost/ || exit 1

CMD ["nginx", "-g", "daemon off;"]
