.PHONY: help build start stop restart logs clean test deploy backup monitor

# Variables
DOCKER_COMPOSE = docker-compose
ENV ?= development
SERVICE ?= all

help: ## Show this help message
	@echo "Available commands:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

build: ## Build all Docker images
	@echo "🔨 Building Docker images..."
	$(DOCKER_COMPOSE) -f docker-compose/docker-compose.yml build
	@echo "✅ Build completed!"

start: ## Start all services
	@echo "🚀 Starting services..."
	$(DOCKER_COMPOSE) -f docker-compose/docker-compose.$(ENV).yml up -d
	@echo "✅ Services started!"

stop: ## Stop all services
	@echo "🛑 Stopping services..."
	$(DOCKER_COMPOSE) -f docker-compose/docker-compose.$(ENV).yml down
	@echo "✅ Services stopped!"

restart: stop start ## Restart all services

logs: ## View logs for all services or specific service
	@if [ "$(SERVICE)" = "all" ]; then \
		$(DOCKER_COMPOSE) -f docker-compose/docker-compose.$(ENV).yml logs -f; \
	else \
		$(DOCKER_COMPOSE) -f docker-compose/docker-compose.$(ENV).yml logs -f $(SERVICE); \
	fi

clean: ## Clean up containers, volumes, and images
	@echo "🧹 Cleaning up..."
	$(DOCKER_COMPOSE) -f docker-compose/docker-compose.$(ENV).yml down -v --rmi all
	docker system prune -f
	@echo "✅ Cleanup completed!"

test: ## Run tests
	@echo "🧪 Running tests..."
	$(DOCKER_COMPOSE) -f docker-compose/docker-compose.test.yml up --abort-on-container-exit
	@echo "✅ Tests completed!"

deploy: ## Deploy to production
	@echo "🚀 Deploying to production..."
	./scripts/deploy.sh production
	@echo "✅ Deployment completed!"

backup: ## Create backup
	@echo "💾 Creating backup..."
	./scripts/backup.sh
	@echo "✅ Backup completed!"

monitor: ## Start monitoring stack
	@echo "📊 Starting monitoring..."
	$(DOCKER_COMPOSE) -f docker-compose/docker-compose.monitoring.yml up -d
	@echo "✅ Monitoring started!"

dev-setup: ## Setup development environment
	@echo "🛠️ Setting up development environment..."
	cp env/.env.development .env
	$(DOCKER_COMPOSE) -f docker-compose/docker-compose.dev.yml up -d
	@echo "✅ Development environment ready!"

prod-setup: ## Setup production environment
	@echo "🏭 Setting up production environment..."
	cp env/.env.production .env
	./scripts/build.sh
	$(DOCKER_COMPOSE) -f docker-compose/docker-compose.yml up -d
	@echo "✅ Production environment ready!"

health: ## Check service health
	@./scripts/health-check.sh

shell: ## Access container shell
	@read -p "Enter container name: " container; \
	docker exec -it $$container /bin/bash || docker exec -it $$container /bin/sh

scale: ## Scale a service
	@read -p "Enter service name: " service; \
	read -p "Enter number of replicas: " replicas; \
	$(DOCKER_COMPOSE) -f docker-compose/docker-compose.$(ENV).yml up -d --scale $$service=$$replicas

db-migrate: ## Run database migrations
	@echo "🗃️ Running database migrations..."
	$(DOCKER_COMPOSE) -f docker-compose/docker-compose.$(ENV).yml exec backend npm run migrate
	@echo "✅ Migrations completed!"

db-seed: ## Seed database with sample data
	@echo "🌱 Seeding database..."
	$(DOCKER_COMPOSE) -f docker-compose/docker-compose.$(ENV).yml exec backend npm run seed
	@echo "✅ Database seeded!"
