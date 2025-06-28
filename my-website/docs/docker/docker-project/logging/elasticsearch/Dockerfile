FROM docker.elastic.co/elasticsearch/elasticsearch:8.8.0

# Install additional plugins
RUN bin/elasticsearch-plugin install analysis-phonetic --batch && \
    bin/elasticsearch-plugin install analysis-icu --batch

# Copy configuration
COPY elasticsearch.yml /usr/share/elasticsearch/config/elasticsearch.yml
COPY jvm.options /usr/share/elasticsearch/config/jvm.options

# Create data and logs directories
USER root
RUN mkdir -p /usr/share/elasticsearch/data && \
    mkdir -p /usr/share/elasticsearch/logs && \
    chown -R elasticsearch:elasticsearch /usr/share/elasticsearch/data && \
    chown -R elasticsearch:elasticsearch /usr/share/elasticsearch/logs

USER elasticsearch

# Expose ports
EXPOSE 9200 9300

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD curl -f http://localhost:9200/_cluster/health || exit 1

# Set environment variables
ENV discovery.type=single-node
ENV xpack.security.enabled=false
ENV xpack.monitoring.collection.enabled=true
