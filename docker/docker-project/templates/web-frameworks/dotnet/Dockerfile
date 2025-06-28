# Multi-stage build for .NET application
FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base

# Install curl for health checks
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Create non-root user
RUN groupadd -r dotnet && useradd -r -g dotnet dotnet

WORKDIR /app
EXPOSE 80
EXPOSE 443

# Build stage
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build

WORKDIR /src

# Copy project file and restore dependencies
COPY ["MyApp.csproj", "."]
RUN dotnet restore "MyApp.csproj"

# Copy source code and build
COPY . .
RUN dotnet build "MyApp.csproj" -c Release -o /app/build

# Publish stage
FROM build AS publish
RUN dotnet publish "MyApp.csproj" -c Release -o /app/publish /p:UseAppHost=false

# Final stage
FROM base AS final

WORKDIR /app

# Copy published files
COPY --from=publish /app/publish .

# Set ownership
RUN chown -R dotnet:dotnet /app

# Switch to non-root user
USER dotnet

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
    CMD curl -f http://localhost/health || exit 1

ENTRYPOINT ["dotnet", "MyApp.dll"]
