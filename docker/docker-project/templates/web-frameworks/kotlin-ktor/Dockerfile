# Multi-stage build for Kotlin Ktor application
FROM gradle:8-jdk17-alpine AS base

# Development stage
FROM base AS development

WORKDIR /app

# Copy build files
COPY build.gradle.kts settings.gradle.kts ./
COPY gradle/ gradle/

# Download dependencies
RUN gradle --no-daemon dependencies

# Copy source code
COPY src/ src/

EXPOSE 8080

CMD ["gradle", "--no-daemon", "run"]

# Build stage
FROM base AS builder

WORKDIR /app

# Copy build files
COPY build.gradle.kts settings.gradle.kts ./
COPY gradle/ gradle/

# Copy source and build
COPY src/ src/
RUN gradle --no-daemon shadowJar

# Production stage
FROM eclipse-temurin:17-jre-alpine AS production

# Install curl for health checks
RUN apk add --no-cache curl

# Create non-root user
RUN addgroup -g 1001 -S ktor && \
    adduser -S ktor -u 1001 -G ktor

WORKDIR /app

# Copy jar file
COPY --from=builder /app/build/libs/*-all.jar app.jar

# Set ownership
RUN chown ktor:ktor app.jar

USER ktor

EXPOSE 8080

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
    CMD curl -f http://localhost:8080/health || exit 1

# JVM optimizations
ENV JAVA_OPTS="-XX:+UseContainerSupport -XX:MaxRAMPercentage=75.0"

CMD ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]
