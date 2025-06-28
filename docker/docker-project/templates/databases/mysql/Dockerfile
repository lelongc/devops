FROM mysql:8.0

# Install additional tools
RUN apt-get update && apt-get install -y \
    curl \
    vim \
    && rm -rf /var/lib/apt/lists/*

# Set custom configuration
ENV MYSQL_DATABASE=myapp \
    MYSQL_USER=appuser \
    MYSQL_PASSWORD=changeme \
    MYSQL_ROOT_PASSWORD=rootpassword

# Copy custom configuration
COPY my.cnf /etc/mysql/conf.d/

# Copy initialization scripts
COPY init-scripts/ /docker-entrypoint-initdb.d/

# Copy backup scripts
COPY scripts/ /usr/local/bin/
RUN chmod +x /usr/local/bin/*.sh

# Create backup directory
RUN mkdir -p /backup && chown mysql:mysql /backup

# Health check
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
    CMD mysqladmin ping -h "localhost" --silent || exit 1

EXPOSE 3306

CMD ["mysqld"]
