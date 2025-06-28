# Custom Jenkins with Docker and additional tools
FROM jenkins/jenkins:lts-alpine

# Switch to root to install additional tools
USER root

# Install Docker CLI, kubectl, and other tools
RUN apk add --no-cache \
    docker-cli \
    docker-compose \
    curl \
    git \
    && curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
    && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Install additional CLI tools
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 \
    && chmod 700 get_helm.sh \
    && ./get_helm.sh

# Install Terraform
RUN wget https://releases.hashicorp.com/terraform/1.6.0/terraform_1.6.0_linux_amd64.zip \
    && unzip terraform_1.6.0_linux_amd64.zip \
    && mv terraform /usr/local/bin/ \
    && rm terraform_1.6.0_linux_amd64.zip

# Copy plugins list
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt

# Install Jenkins plugins
RUN jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt

# Copy custom configuration
COPY jenkins.yaml /var/jenkins_home/casc_configs/jenkins.yaml

# Copy init scripts
COPY init-scripts/ /usr/share/jenkins/ref/init.groovy.d/

# Set environment variables
ENV CASC_JENKINS_CONFIG=/var/jenkins_home/casc_configs/jenkins.yaml
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"

# Switch back to jenkins user
USER jenkins

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD curl -f http://localhost:8080/login || exit 1

EXPOSE 8080 50000
