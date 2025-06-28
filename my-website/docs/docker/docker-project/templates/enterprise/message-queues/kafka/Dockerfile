FROM confluentinc/cp-kafka:7.4.0

# Switch to root to install additional tools
USER root

# Install additional tools
RUN yum update -y && yum install -y \
    curl \
    jq \
    netcat \
    && yum clean all

# Copy custom configuration
COPY server.properties /etc/kafka/server.properties
COPY log4j.properties /etc/kafka/log4j.properties

# Copy initialization scripts
COPY init-scripts/ /usr/local/bin/
RUN chmod +x /usr/local/bin/*.sh

# Set environment variables
ENV KAFKA_BROKER_ID=1 \
    KAFKA_ZOOKEEPER_CONNECT=zookeeper:2181 \
    KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://localhost:9092 \
    KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR=1 \
    KAFKA_GROUP_INITIAL_REBALANCE_DELAY_MS=0 \
    KAFKA_TOOLS_LOG4J_LOGLEVEL=WARN

# Create directories
RUN mkdir -p /var/lib/kafka/data && \
    chown -R appuser:appuser /var/lib/kafka

# Switch back to appuser
USER appuser

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD kafka-broker-api-versions --bootstrap-server localhost:9092 || exit 1

EXPOSE 9092

CMD ["kafka-server-start", "/etc/kafka/server.properties"]
