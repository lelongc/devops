FROM docker.elastic.co/logstash/logstash:8.8.0

# Install additional plugins
RUN bin/logstash-plugin install logstash-filter-translate && \
    bin/logstash-plugin install logstash-filter-cidr

# Copy configuration
COPY logstash.yml /usr/share/logstash/config/logstash.yml
COPY pipelines.yml /usr/share/logstash/config/pipelines.yml
COPY pipeline/ /usr/share/logstash/pipeline/

# Copy patterns
COPY patterns/ /usr/share/logstash/patterns/

# Create logs directory
USER root
RUN mkdir -p /usr/share/logstash/logs && \
    chown -R logstash:logstash /usr/share/logstash/logs

USER logstash

# Expose ports
EXPOSE 5044 5045 9600

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD curl -f http://localhost:9600/ || exit 1
