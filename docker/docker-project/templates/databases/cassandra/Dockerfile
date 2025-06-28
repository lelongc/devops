FROM cassandra:4.0

# Install additional tools
RUN apt-get update && apt-get install -y \
    curl \
    vim \
    netcat \
    && rm -rf /var/lib/apt/lists/*

# Set environment variables
ENV CASSANDRA_CLUSTER_NAME=MyCluster \
    CASSANDRA_DC=dc1 \
    CASSANDRA_RACK=rack1 \
    CASSANDRA_ENDPOINT_SNITCH=GossipingPropertyFileSnitch

# Copy custom configuration
COPY cassandra.yaml /etc/cassandra/cassandra.yaml
COPY cassandra-rackdc.properties /etc/cassandra/cassandra-rackdc.properties

# Copy initialization scripts
COPY init-scripts/ /docker-entrypoint-initdb.d/

# Copy backup scripts
COPY scripts/ /usr/local/bin/
RUN chmod +x /usr/local/bin/*.sh

# Create backup directory
RUN mkdir -p /backup && chown cassandra:cassandra /backup

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD cqlsh -e "describe keyspaces" || exit 1

EXPOSE 7000 7001 7199 9042 9160

CMD ["cassandra", "-f"]
