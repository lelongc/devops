# Multi-stage build for Scala Play application
FROM sbtscala/scala-sbt:eclipse-temurin-17.0.4_1.7.1_3.2.0 AS base

# Development stage
FROM base AS development

WORKDIR /app

# Copy SBT files
COPY build.sbt project/ ./

# Download dependencies
RUN sbt update

# Copy source code
COPY . .

EXPOSE 9000

CMD ["sbt", "run"]

# Build stage
FROM base AS builder

WORKDIR /app

# Copy build files
COPY build.sbt project/ ./

# Copy source and build
COPY . .
RUN sbt stage

# Production stage
FROM eclipse-temurin:17-jre-alpine AS production

# Install curl for health checks
RUN apk add --no-cache curl

# Create non-root user
RUN addgroup -g 1001 -S play && \
    adduser -S play -u 1001 -G play

WORKDIR /app

# Copy built application
COPY --from=builder /app/target/universal/stage .

# Set ownership
RUN chown -R play:play .

USER play

EXPOSE 9000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
    CMD curl -f http://localhost:9000/health || exit 1

# JVM optimizations
ENV JAVA_OPTS="-XX:+UseContainerSupport -XX:MaxRAMPercentage=75.0"

CMD ["./bin/myapp"]
