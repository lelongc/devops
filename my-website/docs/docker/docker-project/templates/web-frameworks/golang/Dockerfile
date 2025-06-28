# Multi-stage build for Go application
FROM golang:1.21-alpine AS base

# Install git and ca-certificates
RUN apk add --no-cache git ca-certificates tzdata

# Development stage
FROM base AS development
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
EXPOSE 8080
CMD ["go", "run", "main.go"]

# Build stage
FROM base AS builder

WORKDIR /app

# Copy go mod files
COPY go.mod go.sum ./
RUN go mod download

# Copy source code
COPY . .

# Build the binary
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build \
    -ldflags='-w -s -extldflags "-static"' \
    -a -installsuffix cgo \
    -o main .

# Production stage - Use scratch for minimal image
FROM scratch AS production

# Copy ca-certificates and timezone data
COPY --from=base /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=base /usr/share/zoneinfo /usr/share/zoneinfo

# Copy the binary
COPY --from=builder /app/main /main

# Create non-root user (using numeric IDs for scratch)
USER 65534:65534

EXPOSE 8080

# Health check (Note: scratch doesn't have curl, so use custom endpoint)
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
    CMD ["/main", "-health-check"]

ENTRYPOINT ["/main"]
