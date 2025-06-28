# Qt application development and build environment
FROM ubuntu:22.04 AS base

# Prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    wget \
    xvfb \
    libgl1-mesa-dev \
    libxkbcommon-x11-0 \
    libxcb-icccm4 \
    libxcb-image0 \
    libxcb-keysyms1 \
    libxcb-randr0 \
    libxcb-render-util0 \
    libxcb-xinerama0 \
    && rm -rf /var/lib/apt/lists/*

# Development stage
FROM base AS development

# Install Qt
ARG QT_VERSION=6.5.0
RUN wget -O qt-installer.run https://download.qt.io/archive/qt/6.5/6.5.0/qt-opensource-linux-x64-6.5.0.run && \
    chmod +x qt-installer.run && \
    ./qt-installer.run --script qt-installer-script.js --platform minimal && \
    rm qt-installer.run

# Set Qt environment
ENV PATH="/opt/Qt/${QT_VERSION}/gcc_64/bin:${PATH}"
ENV LD_LIBRARY_PATH="/opt/Qt/${QT_VERSION}/gcc_64/lib:${LD_LIBRARY_PATH}"

WORKDIR /app

# Copy CMake files
COPY CMakeLists.txt ./

# Copy source code
COPY . .

# Development command with X11 forwarding
CMD ["bash", "-c", "xvfb-run -a cmake . && make && ./myapp"]

# Build stage
FROM development AS builder

# Build the application
RUN cmake . && make

# Production stage (for headless applications)
FROM ubuntu:22.04 AS production

# Install runtime dependencies
RUN apt-get update && apt-get install -y \
    libgl1-mesa-glx \
    libxkbcommon-x11-0 \
    libxcb1 \
    && rm -rf /var/lib/apt/lists/*

# Create non-root user
RUN groupadd -r qtuser && useradd -r -g qtuser qtuser

WORKDIR /app

# Copy built application
COPY --from=builder --chown=qtuser:qtuser /app/myapp .

USER qtuser

# For headless Qt applications
ENV QT_QPA_PLATFORM=offscreen

CMD ["./myapp"]
