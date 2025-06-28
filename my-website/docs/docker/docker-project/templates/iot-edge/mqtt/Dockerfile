# MQTT Broker (Eclipse Mosquitto) for IoT applications
FROM eclipse-mosquitto:2.0-openssl AS base

# Development stage
FROM base AS development

# Copy development configuration
COPY config/mosquitto-dev.conf /mosquitto/config/mosquitto.conf

# Copy password file for development
COPY config/passwd /mosquitto/config/passwd

EXPOSE 1883 8883 9001

# Production stage
FROM base AS production

# Install curl for health checks
USER root
RUN apk add --no-cache curl
USER mosquitto

# Copy production configuration
COPY config/mosquitto-prod.conf /mosquitto/config/mosquitto.conf

# Copy SSL certificates
COPY certs/ /mosquitto/certs/

# Copy authentication files
COPY config/passwd /mosquitto/config/passwd
COPY config/acl /mosquitto/config/acl

# Set proper permissions
USER root
RUN chown -R mosquitto:mosquitto /mosquitto/config && \
    chown -R mosquitto:mosquitto /mosquitto/certs && \
    chmod 400 /mosquitto/certs/*.key
USER mosquitto

EXPOSE 1883 8883 9001

# Health check
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
    CMD mosquitto_pub -h localhost -t health/check -m "health" -q 1 || exit 1

CMD ["/usr/sbin/mosquitto", "-c", "/mosquitto/config/mosquitto.conf"]
