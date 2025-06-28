# Hyperledger Fabric development environment
FROM ubuntu:20.04 AS base

# Prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    build-essential \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Install Docker (for Fabric samples)
RUN curl -fsSL https://get.docker.com -o get-docker.sh && \
    sh get-docker.sh && \
    rm get-docker.sh

# Install Docker Compose
RUN pip3 install docker-compose

# Install Go
ENV GO_VERSION=1.19.5
RUN wget https://golang.org/dl/go${GO_VERSION}.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz && \
    rm go${GO_VERSION}.linux-amd64.tar.gz

ENV PATH="/usr/local/go/bin:${PATH}"

# Install Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs

# Development stage
FROM base AS development

WORKDIR /fabric

# Install Fabric binaries and samples
RUN curl -sSL https://bit.ly/2ysbOFE | bash -s -- 2.4.7 1.5.2

# Set Fabric environment
ENV PATH="/fabric/fabric-samples/bin:${PATH}"
ENV FABRIC_CFG_PATH="/fabric/fabric-samples/config"

# Copy chaincode and application files
COPY . .

EXPOSE 7050 7051 7052 7053 7054

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD peer version || exit 1

# Start Fabric network
CMD ["./scripts/start-network.sh"]

# Artifacts stage
FROM alpine AS fabric-artifacts

# Copy built chaincode
COPY --from=development /fabric/chaincode /chaincode

VOLUME ["/chaincode"]

CMD ["sh", "-c", "echo 'Fabric chaincode available in /chaincode'"]
