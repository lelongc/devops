# Multi-stage build for Node.js application
FROM node:18-alpine AS base

# Install security updates and dumb-init
RUN apk add --no-cache \
    dumb-init \
    && addgroup -g 1001 -S nodejs \
    && adduser -S nodejs -u 1001

# Dependencies stage
FROM base AS dependencies
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production && npm cache clean --force

# Development stage
FROM base AS development
WORKDIR /app
RUN chown -R nodejs:nodejs /app
USER nodejs
COPY package*.json ./
RUN npm ci
COPY --chown=nodejs:nodejs . .
EXPOSE 3000
CMD ["dumb-init", "npm", "run", "dev"]

# Build stage (if needed)
FROM development AS builder
RUN npm run build

# Production stage
FROM base AS production

ENV NODE_ENV=production
ENV PORT=3000

WORKDIR /app
RUN chown -R nodejs:nodejs /app
USER nodejs

# Copy production dependencies
COPY --from=dependencies --chown=nodejs:nodejs /app/node_modules ./node_modules

# Copy application files
COPY --chown=nodejs:nodejs package*.json ./
COPY --chown=nodejs:nodejs . .

# Copy built files if they exist
COPY --from=builder --chown=nodejs:nodejs /app/dist ./dist 2>/dev/null || true

EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:3000/health || exit 1

CMD ["dumb-init", "node", "server.js"]
