FROM apachepulsar/pulsar:3.1.0

# Switch to root to install additional tools
USER root

# Install additional tools
RUN apt-get update && apt-get install -y \
    curl \
    jq \
    netcat \
    && rm -rf /var/lib/apt/lists/*

# Copy custom configuration
COPY broker.conf /pulsar/conf/broker.conf
COPY bookkeeper.conf /pulsar/conf/bookkeeper.conf
COPY zookeeper.conf /pulsar/conf/zookeeper.conf

# Copy initialization scripts
COPY init-scripts/ /usr/local/bin/
RUN chmod +x /usr/local/bin/*.sh

# Set environment variables
ENV PULSAR_MEM="-Xms512m -Xmx512m -XX:MaxDirectMemorySize=256m" \
    PULSAR_GC="-XX:+UseG1GC -XX:MaxGCPauseMillis=10"

# Create directories
RUN mkdir -p /pulsar/data /pulsar/logs && \
    chown -R pulsar:pulsar /pulsar/data /pulsar/logs

# Switch back to pulsar user
USER pulsar

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD curl -f http://localhost:8080/admin/v2/namespaces/public || exit 1

EXPOSE 6650 8080

CMD ["bin/pulsar", "standalone"]
