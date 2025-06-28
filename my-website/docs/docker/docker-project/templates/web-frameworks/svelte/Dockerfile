# Multi-stage build for Svelte application
FROM node:18-alpine AS base

WORKDIR /app
RUN apk add --no-cache git

# Dependencies stage
FROM base AS dependencies
COPY package*.json ./
RUN npm ci --only=production

# Development stage
FROM base AS development
COPY package*.json ./
RUN npm ci
COPY . .
EXPOSE 5173
CMD ["npm", "run", "dev", "--", "--host", "0.0.0.0"]

# Build stage
FROM development AS builder
RUN npm run build

# Production stage
FROM nginx:1.21-alpine AS production

# Install curl for health checks
RUN apk add --no-cache curl

# Copy built Svelte application
COPY --from=builder /app/dist /usr/share/nginx/html

# Copy custom nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Create non-root user
RUN addgroup -g 1001 -S svelte && \
    adduser -S svelte -u 1001 -G svelte

# Set permissions
RUN chown -R svelte:svelte /usr/share/nginx/html && \
    chown -R svelte:svelte /var/cache/nginx && \
    chown -R svelte:svelte /var/log/nginx && \
    chown -R svelte:svelte /etc/nginx/conf.d && \
    mkdir -p /var/cache/nginx/client_temp && \
    chown -R svelte:svelte /var/cache/nginx

USER svelte

EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD curl -f http://localhost/ || exit 1

CMD ["nginx", "-g", "daemon off;"]
