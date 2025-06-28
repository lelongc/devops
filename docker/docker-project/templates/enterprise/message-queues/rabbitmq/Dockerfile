FROM rabbitmq:3-management-alpine

# Install additional tools
RUN apk add --no-cache \
    curl \
    jq

# Copy custom configuration
COPY rabbitmq.conf /etc/rabbitmq/rabbitmq.conf
COPY definitions.json /etc/rabbitmq/definitions.json

# Copy enabled plugins
COPY enabled_plugins /etc/rabbitmq/enabled_plugins

# Copy SSL certificates
COPY ssl/ /etc/rabbitmq/ssl/

# Set environment variables
ENV RABBITMQ_DEFAULT_USER=admin \
    RABBITMQ_DEFAULT_PASS=changeme \
    RABBITMQ_DEFAULT_VHOST=/ \
    RABBITMQ_ERLANG_COOKIE=rabbitmq-cookie

# Create logs directory
RUN mkdir -p /var/log/rabbitmq && \
    chown rabbitmq:rabbitmq /var/log/rabbitmq

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
    CMD rabbitmq-diagnostics ping || exit 1

EXPOSE 5672 15672 25672

CMD ["rabbitmq-server"]
