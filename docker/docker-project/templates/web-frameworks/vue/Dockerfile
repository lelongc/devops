# Multi-stage build for Vue.js application
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
EXPOSE 8080
CMD ["npm", "run", "serve"]

# Build stage
FROM development AS builder
RUN npm run build

# Production stage
FROM nginx:1.21-alpine AS production

# Install curl and other utilities
RUN apk add --no-cache curl

# Copy built Vue application
COPY --from=builder /app/dist /usr/share/nginx/html

# Copy custom nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Security: Create non-root user
RUN addgroup -g 1001 -S vuegroup && \
    adduser -S vueuser -u 1001 -G vuegroup

# Set permissions
RUN chown -R vueuser:vuegroup /usr/share/nginx/html && \
    chown -R vueuser:vuegroup /var/cache/nginx && \
    chown -R vueuser:vuegroup /var/log/nginx && \
    chown -R vueuser:vuegroup /etc/nginx/conf.d && \
    mkdir -p /var/cache/nginx/client_temp && \
    chown -R vueuser:vuegroup /var/cache/nginx

USER vueuser

EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD curl -f http://localhost/ || exit 1

CMD ["nginx", "-g", "daemon off;"]
