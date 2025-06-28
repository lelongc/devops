# Multi-stage build for Blazor application
FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base

# Install curl for health checks
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

WORKDIR /app
EXPOSE 80
EXPOSE 443

# Build stage
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build

WORKDIR /src

# Copy project file and restore dependencies
COPY ["BlazorApp.csproj", "."]
RUN dotnet restore "BlazorApp.csproj"

# Copy source code and build
COPY . .
RUN dotnet build "BlazorApp.csproj" -c Release -o /app/build

# Publish stage
FROM build AS publish
RUN dotnet publish "BlazorApp.csproj" -c Release -o /app/publish /p:UseAppHost=false

# Final stage
FROM base AS final

# Create non-root user
RUN groupadd -r blazor && useradd -r -g blazor blazor

WORKDIR /app

# Copy published files
COPY --from=publish /app/publish .

# Set ownership
RUN chown -R blazor:blazor /app

# Switch to non-root user
USER blazor

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
    CMD curl -f http://localhost/health || exit 1

ENTRYPOINT ["dotnet", "BlazorApp.dll"]
