FROM grafana/grafana:10.0.0

# Switch to root to install plugins
USER root

# Install additional plugins
RUN grafana-cli plugins install grafana-piechart-panel && \
    grafana-cli plugins install grafana-worldmap-panel && \
    grafana-cli plugins install blackmirror1-statusbygroup-panel && \
    grafana-cli plugins install grafana-clock-panel && \
    grafana-cli plugins install grafana-simple-json-datasource

# Copy custom configuration
COPY grafana.ini /etc/grafana/grafana.ini

# Copy provisioning configurations
COPY provisioning/ /etc/grafana/provisioning/

# Copy custom dashboards
COPY dashboards/ /var/lib/grafana/dashboards/

# Create necessary directories and set permissions
RUN mkdir -p /var/lib/grafana/plugins && \
    mkdir -p /var/log/grafana && \
    chown -R grafana:grafana /var/lib/grafana && \
    chown -R grafana:grafana /var/log/grafana && \
    chown -R grafana:grafana /etc/grafana

# Switch back to grafana user
USER grafana

EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
    CMD curl -f http://localhost:3000/api/health || exit 1
