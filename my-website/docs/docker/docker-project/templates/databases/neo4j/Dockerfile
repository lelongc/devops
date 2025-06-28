FROM neo4j:5.12-community

# Install additional tools
USER root
RUN apt-get update && apt-get install -y \
    curl \
    jq \
    && rm -rf /var/lib/apt/lists/*

# Set environment variables
ENV NEO4J_AUTH=neo4j/changeme \
    NEO4J_PLUGINS='["apoc", "graph-data-science"]' \
    NEO4J_dbms_security_procedures_unrestricted=apoc.*,gds.*

# Copy custom configuration
COPY neo4j.conf /conf/neo4j.conf

# Copy initialization scripts
COPY init-scripts/ /var/lib/neo4j/import/

# Copy backup scripts
COPY scripts/ /usr/local/bin/
RUN chmod +x /usr/local/bin/*.sh

# Create backup directory
RUN mkdir -p /backup && chown neo4j:neo4j /backup

USER neo4j

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
    CMD cypher-shell "RETURN 1" || exit 1

EXPOSE 7474 7687

CMD ["neo4j"]
