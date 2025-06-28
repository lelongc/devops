FROM hashicorp/vault:1.15

# Switch to root to install additional tools
USER root

# Install additional tools
RUN apk add --no-cache \
    curl \
    jq \
    bash

# Copy custom configuration
COPY vault.hcl /vault/config/vault.hcl

# Copy initialization scripts
COPY init-scripts/ /vault/init/

# Copy SSL certificates
COPY ssl/ /vault/ssl/

# Set permissions
RUN chown -R vault:vault /vault && \
    chmod 755 /vault/init/*.sh

# Switch back to vault user
USER vault

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
    CMD vault status || exit 1

EXPOSE 8200

# Start Vault server
CMD ["vault", "server", "-config=/vault/config/vault.hcl"]
