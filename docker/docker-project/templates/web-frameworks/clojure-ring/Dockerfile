# Multi-stage build for Clojure Ring application
FROM clojure:temurin-17-lein-alpine AS base

# Development stage
FROM base AS development

WORKDIR /app

# Copy Leiningen files
COPY project.clj ./

# Download dependencies
RUN lein deps

# Copy source code
COPY . .

EXPOSE 3000

CMD ["lein", "ring", "server-headless"]

# Build stage
FROM base AS builder

WORKDIR /app

# Copy project files
COPY project.clj ./

# Copy source and build
COPY . .
RUN lein uberjar

# Production stage
FROM eclipse-temurin:17-jre-alpine AS production

# Install curl for health checks
RUN apk add --no-cache curl

# Create non-root user
RUN addgroup -g 1001 -S clojure && \
    adduser -S clojure -u 1001 -G clojure

WORKDIR /app

# Copy uberjar
COPY --from=builder /app/target/*-standalone.jar app.jar

# Set ownership
RUN chown clojure:clojure app.jar

USER clojure

EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
    CMD curl -f http://localhost:3000/health || exit 1

# JVM optimizations
ENV JAVA_OPTS="-XX:+UseContainerSupport -XX:MaxRAMPercentage=75.0"

CMD ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]
