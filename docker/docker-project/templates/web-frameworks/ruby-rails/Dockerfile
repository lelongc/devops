# Multi-stage build for Ruby on Rails application
FROM ruby:3.2-alpine AS base

# Install system dependencies
RUN apk add --no-cache \
    build-base \
    postgresql-dev \
    git \
    curl \
    nodejs \
    yarn \
    tzdata

# Development stage
FROM base AS development

WORKDIR /app

# Copy Gemfile
COPY Gemfile* ./

# Install gems
RUN bundle install

# Copy application files
COPY . .

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]

# Build stage
FROM development AS builder

# Precompile assets
RUN RAILS_ENV=production bundle exec rake assets:precompile

# Production stage
FROM ruby:3.2-alpine AS production

# Install runtime dependencies
RUN apk add --no-cache \
    postgresql-client \
    tzdata \
    curl

# Create non-root user
RUN addgroup -g 1001 -S rails && \
    adduser -S rails -u 1001 -G rails

WORKDIR /app

# Copy Gemfile and install production gems
COPY Gemfile* ./
RUN bundle config set --local deployment 'true' && \
    bundle config set --local without 'development test' && \
    bundle install

# Copy application files
COPY --chown=rails:rails . .

# Copy precompiled assets
COPY --from=builder --chown=rails:rails /app/public/assets ./public/assets

# Set ownership
RUN chown -R rails:rails /app

USER rails

EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:3000/health || exit 1

CMD ["rails", "server", "-b", "0.0.0.0", "-e", "production"]
