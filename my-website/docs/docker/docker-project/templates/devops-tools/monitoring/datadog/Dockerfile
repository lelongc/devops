FROM datadog/agent:latest

# Copy custom configuration
COPY datadog.yaml /etc/datadog-agent/datadog.yaml

# Copy custom checks
COPY checks.d/ /etc/datadog-agent/checks.d/
COPY conf.d/ /etc/datadog-agent/conf.d/

# Set environment variables
ENV DD_API_KEY="" \
    DD_SITE="datadoghq.com" \
    DD_LOGS_ENABLED=true \
    DD_LOGS_CONFIG_CONTAINER_COLLECT_ALL=true \
    DD_PROCESS_AGENT_ENABLED=true \
    DD_DOCKER_LABELS_AS_TAGS='{"*":"%%label%%"}' \
    DD_KUBERNETES_KUBELET_HOST=$NODE_IP

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
    CMD datadog-agent health || exit 1

# Use the default entrypoint from base image
