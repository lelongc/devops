# Selenium testing environment
FROM selenoid/vnc:chrome_78.0

# Switch to root to install additional tools
USER root

# Install Python and testing tools
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install Python packages
RUN pip3 install \
    selenium \
    pytest \
    pytest-html \
    pytest-xdist \
    allure-pytest \
    requests

# Install Node.js for JavaScript tests
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs

# Install WebDriver and testing frameworks
RUN npm install -g \
    webdriver-manager \
    mocha \
    jest \
    cypress

# Copy test files
COPY tests/ /tests/
COPY package*.json ./

# Install project dependencies
RUN npm ci

# Set working directory
WORKDIR /tests

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
    CMD curl -f http://localhost:4444/wd/hub/status || exit 1

EXPOSE 4444 5900

# Run tests
CMD ["python3", "-m", "pytest", "--html=report.html"]
