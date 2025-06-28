# Multi-stage build for Laravel application
FROM php:8.2-fpm-alpine AS base

# Install system dependencies
RUN apk add --no-cache \
    curl \
    libpng-dev \
    libzip-dev \
    zip \
    unzip \
    git \
    supervisor

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql mbstring zip exif pcntl bcmath gd

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Development stage
FROM base AS development

WORKDIR /var/www

# Copy composer files
COPY composer*.json ./

# Install dependencies
RUN composer install --no-scripts --no-autoloader

# Copy application files
COPY . .

# Set permissions
RUN chown -R www-data:www-data /var/www && \
    chmod -R 755 /var/www/storage

# Generate autoloader
RUN composer dump-autoload

EXPOSE 9000

CMD ["php-fpm"]

# Production stage
FROM base AS production

# Create non-root user
RUN addgroup -g 1001 -S laravel && \
    adduser -S laravel -u 1001 -G laravel

WORKDIR /var/www

# Install production dependencies
COPY composer*.json ./
RUN composer install --no-dev --optimize-autoloader --no-scripts

# Copy application files
COPY --chown=laravel:laravel . .

# Set proper permissions
RUN chown -R laravel:laravel /var/www && \
    chmod -R 755 /var/www/storage /var/www/bootstrap/cache

# Generate application key and cache
RUN php artisan key:generate && \
    php artisan config:cache && \
    php artisan route:cache && \
    php artisan view:cache

USER laravel

EXPOSE 9000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD php artisan health:check || exit 1

CMD ["php-fpm"]
