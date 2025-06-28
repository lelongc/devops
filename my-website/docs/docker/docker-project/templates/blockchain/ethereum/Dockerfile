# Multi-stage build for Ethereum DApp
FROM node:18-alpine AS base

# Install git and python for native dependencies
RUN apk add --no-cache git python3 make g++

# Development stage
FROM base AS development

WORKDIR /app

# Install global tools
RUN npm install -g truffle ganache hardhat

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy source code
COPY . .

EXPOSE 8545 3000

# Development command
CMD ["npm", "run", "dev"]

# Build stage
FROM development AS builder

# Compile contracts
RUN npm run compile

# Build frontend
RUN npm run build

# Production stage
FROM nginx:alpine AS production

# Install curl for health checks
RUN apk add --no-cache curl

# Copy built DApp
COPY --from=builder /app/build /usr/share/nginx/html

# Copy nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Create non-root user
RUN addgroup -g 1001 -S dapp && \
    adduser -S dapp -u 1001 -G dapp

# Set permissions
RUN chown -R dapp:dapp /usr/share/nginx/html && \
    chown -R dapp:dapp /var/cache/nginx && \
    chown -R dapp:dapp /var/log/nginx && \
    chown -R dapp:dapp /etc/nginx/conf.d

USER dapp

EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
    CMD curl -f http://localhost/ || exit 1

CMD ["nginx", "-g", "daemon off;"]
