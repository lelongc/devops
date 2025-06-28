# Multi-stage build for Angular application
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
EXPOSE 4200
CMD ["npm", "start", "--", "--host", "0.0.0.0"]

# Build stage
FROM development AS builder
RUN npm run build --prod

# Production stage
FROM nginx:1.21-alpine AS production

# Install curl for health checks
RUN apk add --no-cache curl

# Copy built Angular application
COPY --from=builder /app/dist /usr/share/nginx/html

# Copy custom nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Create non-root user
RUN addgroup -g 1001 -S angular && \
    adduser -S angular -u 1001 -G angular

# Set permissions
RUN chown -R angular:angular /usr/share/nginx/html && \
    chown -R angular:angular /var/cache/nginx && \
    chown -R angular:angular /var/log/nginx && \
    chown -R angular:angular /etc/nginx/conf.d && \
    mkdir -p /var/cache/nginx/client_temp && \
    chown -R angular:angular /var/cache/nginx

USER angular

EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD curl -f http://localhost/ || exit 1

CMD ["nginx", "-g", "daemon off;"]
