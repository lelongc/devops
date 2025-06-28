FROM docker.elastic.co/kibana/kibana:8.8.0

# Copy configuration
COPY kibana.yml /usr/share/kibana/config/kibana.yml

# Copy saved objects and dashboards
COPY saved_objects/ /usr/share/kibana/saved_objects/

# Create logs directory
USER root
RUN mkdir -p /usr/share/kibana/logs && \
    chown -R kibana:kibana /usr/share/kibana/logs

USER kibana

# Expose port
EXPOSE 5601

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD curl -f http://localhost:5601/api/status || exit 1
