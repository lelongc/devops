FROM grafana/grafana:10.0.0

# Install plugins
RUN grafana-cli plugins install grafana-piechart-panel && \
    grafana-cli plugins install grafana-worldmap-panel && \
    grafana-cli plugins install blackmirror1-statusbygroup-panel

# Copy provisioning configurations
COPY provisioning/ /etc/grafana/provisioning/
COPY dashboards/ /var/lib/grafana/dashboards/

# Copy custom grafana.ini
COPY grafana.ini /etc/grafana/grafana.ini

# Create necessary directories
USER root
RUN mkdir -p /var/lib/grafana/plugins && \
    mkdir -p /var/log/grafana && \
    chown -R grafana:grafana /var/lib/grafana && \
    chown -R grafana:grafana /var/log/grafana && \
    chown -R grafana:grafana /etc/grafana

USER grafana

# Expose port
EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
    CMD curl -f http://localhost:3000/api/health || exit 1
