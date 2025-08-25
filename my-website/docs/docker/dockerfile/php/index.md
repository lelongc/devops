# PHP Projects with Docker

Tổng hợp các loại project PHP phổ biến với Dockerfile tương ứng.

## 1. Basic PHP Application

### index.php

```php
<?php
echo "Hello World from PHP!\n";
echo "Current time: " . date('Y-m-d H:i:s') . "\n";
echo "PHP Version: " . phpversion() . "\n";

// Keep script running for demonstration
while (true) {
    echo "Application is running... " . date('H:i:s') . "\n";
    sleep(10);
}
?>
```

### Dockerfile

```dockerfile
FROM php:8.3-cli
WORKDIR /app
COPY . .
CMD ["php", "index.php"]
```

## 2. Apache + PHP Web Server

### index.php

```php
<!DOCTYPE html>
<html>
<head>
    <title>Hello World PHP</title>
    <style>
        body { font-family: Arial, sans-serif; text-align: center; margin-top: 50px; }
        .container { max-width: 600px; margin: 0 auto; }
    </style>
</head>
<body>
    <div class="container">
        <h1>Hello World from PHP + Apache!</h1>
        <p>Current time: <?php echo date('Y-m-d H:i:s'); ?></p>
        <p>PHP Version: <?php echo phpversion(); ?></p>
        <p>Server: <?php echo $_SERVER['SERVER_SOFTWARE']; ?></p>

        <h2>Server Information</h2>
        <ul>
            <li>Document Root: <?php echo $_SERVER['DOCUMENT_ROOT']; ?></li>
            <li>Server Name: <?php echo $_SERVER['SERVER_NAME']; ?></li>
            <li>Request Method: <?php echo $_SERVER['REQUEST_METHOD']; ?></li>
        </ul>
    </div>
</body>
</html>
```

### Dockerfile

```dockerfile
FROM php:8.3-apache
WORKDIR /var/www/html
COPY . .
RUN chown -R www-data:www-data /var/www/html
EXPOSE 80
CMD ["apache2-foreground"]
```

## 3. Laravel Application

### composer.json

```json
{
  "name": "laravel/laravel",
  "type": "project",
  "description": "Hello World Laravel Application",
  "require": {
    "php": "^8.1",
    "laravel/framework": "^10.0"
  },
  "autoload": {
    "psr-4": {
      "App\\": "app/",
      "Database\\Factories\\": "database/factories/",
      "Database\\Seeders\\": "database/seeders/"
    }
  },
  "scripts": {
    "post-autoload-dump": [
      "Illuminate\\Foundation\\ComposerScripts::postAutoloadDump",
      "@php artisan package:discover --ansi"
    ]
  }
}
```

### routes/web.php

```php
<?php

use Illuminate\Support\Facades\Route;
use Illuminate\Http\Request;

Route::get('/', function () {
    return view('welcome');
});

Route::get('/api/hello', function () {
    return response()->json([
        'message' => 'Hello World from Laravel API!',
        'timestamp' => now()->toDateTimeString(),
        'framework' => 'Laravel ' . app()->version()
    ]);
});

Route::post('/api/echo', function (Request $request) {
    return response()->json([
        'echo' => 'You said: ' . $request->input('message', 'No message provided'),
        'timestamp' => now()->toDateTimeString()
    ]);
});

Route::get('/health', function () {
    return response()->json([
        'status' => 'healthy',
        'framework' => 'Laravel',
        'php_version' => phpversion()
    ]);
});
```

### resources/views/welcome.blade.php

```php
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hello World Laravel</title>
    <style>
        body { font-family: Arial, sans-serif; text-align: center; background: #f8f9fa; }
        .container { max-width: 800px; margin: 50px auto; padding: 20px; }
        .card { background: white; border-radius: 8px; padding: 30px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .btn { background: #007bff; color: white; padding: 10px 20px; border: none; border-radius: 4px; }
    </style>
</head>
<body>
    <div class="container">
        <div class="card">
            <h1>Hello World from Laravel!</h1>
            <p>Welcome to your Laravel application</p>
            <p>Current time: {{ now()->format('Y-m-d H:i:s') }}</p>
            <p>Laravel Version: {{ app()->version() }}</p>

            <div style="margin-top: 30px;">
                <a href="/api/hello" class="btn">Test API</a>
                <a href="/health" class="btn">Health Check</a>
            </div>
        </div>
    </div>
</body>
</html>
```

### Dockerfile

```dockerfile
FROM php:8.3-fpm

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    nginx

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

# Copy application files
COPY . .

# Install Laravel dependencies
RUN composer install --optimize-autoloader --no-dev

# Set permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html/storage

# Nginx configuration
COPY nginx.conf /etc/nginx/sites-available/default

EXPOSE 80

# Start script
COPY start.sh /start.sh
RUN chmod +x /start.sh
CMD ["/start.sh"]
```

### nginx.conf

```nginx
server {
    listen 80;
    server_name localhost;
    root /var/www/html/public;
    index index.php index.html;

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    location ~ \.php$ {
        fastcgi_pass 127.0.0.1:9000;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $realpath_root$fastcgi_script_name;
        include fastcgi_params;
    }
}
```

### start.sh

```bash
#!/bin/bash
php-fpm -D
nginx -g "daemon off;"
```

## 4. Symfony Application

### composer.json

```json
{
  "name": "symfony/hello-world",
  "type": "project",
  "require": {
    "php": ">=8.1",
    "symfony/framework-bundle": "^6.0",
    "symfony/runtime": "^6.0"
  },
  "autoload": {
    "psr-4": {
      "App\\": "src/"
    }
  }
}
```

### src/Controller/HelloController.php

```php
<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class HelloController extends AbstractController
{
    #[Route('/', name: 'home')]
    public function index(): Response
    {
        return $this->render('hello.html.twig', [
            'message' => 'Hello World from Symfony!',
            'timestamp' => new \DateTime()
        ]);
    }

    #[Route('/api/hello', name: 'api_hello')]
    public function apiHello(): JsonResponse
    {
        return $this->json([
            'message' => 'Hello World from Symfony API!',
            'timestamp' => (new \DateTime())->format('Y-m-d H:i:s'),
            'framework' => 'Symfony'
        ]);
    }

    #[Route('/api/echo', name: 'api_echo', methods: ['POST'])]
    public function echo(Request $request): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        return $this->json([
            'echo' => 'You said: ' . ($data['message'] ?? 'No message provided'),
            'timestamp' => (new \DateTime())->format('Y-m-d H:i:s')
        ]);
    }

    #[Route('/health', name: 'health')]
    public function health(): JsonResponse
    {
        return $this->json([
            'status' => 'healthy',
            'framework' => 'Symfony',
            'php_version' => phpversion()
        ]);
    }
}
```

### templates/hello.html.twig

```html
<!DOCTYPE html>
<html>
  <head>
    <title>Hello World Symfony</title>
    <style>
      body {
        font-family: Arial, sans-serif;
        text-align: center;
        background: #f8f9fa;
      }
      .container {
        max-width: 800px;
        margin: 50px auto;
        padding: 20px;
      }
      .card {
        background: white;
        border-radius: 8px;
        padding: 30px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
      }
    </style>
  </head>
  <body>
    <div class="container">
      <div class="card">
        <h1>{{ message }}</h1>
        <p>Welcome to your Symfony application</p>
        <p>Current time: {{ timestamp|date('Y-m-d H:i:s') }}</p>
        <p>Symfony Framework</p>
      </div>
    </div>
  </body>
</html>
```

### Dockerfile

```dockerfile
FROM php:8.3-apache

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libicu-dev \
    libzip-dev

# Install PHP extensions
RUN docker-php-ext-install intl zip pdo_mysql

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Enable Apache rewrite module
RUN a2enmod rewrite

WORKDIR /var/www/html

# Copy application
COPY . .

# Install dependencies
RUN composer install --optimize-autoloader --no-dev

# Set permissions
RUN chown -R www-data:www-data /var/www/html

EXPOSE 80
CMD ["apache2-foreground"]
```

## 5. CodeIgniter 4 Application

### app/Controllers/Home.php

```php
<?php

namespace App\Controllers;

class Home extends BaseController
{
    public function index()
    {
        return view('welcome_message', [
            'message' => 'Hello World from CodeIgniter 4!',
            'timestamp' => date('Y-m-d H:i:s')
        ]);
    }

    public function apiHello()
    {
        return $this->response->setJSON([
            'message' => 'Hello World from CodeIgniter 4 API!',
            'timestamp' => date('Y-m-d H:i:s'),
            'framework' => 'CodeIgniter 4'
        ]);
    }

    public function echo()
    {
        $request = service('request');
        $data = $request->getJSON(true);

        return $this->response->setJSON([
            'echo' => 'You said: ' . ($data['message'] ?? 'No message provided'),
            'timestamp' => date('Y-m-d H:i:s')
        ]);
    }

    public function health()
    {
        return $this->response->setJSON([
            'status' => 'healthy',
            'framework' => 'CodeIgniter 4',
            'php_version' => phpversion()
        ]);
    }
}
```

### app/Config/Routes.php

```php
<?php

use CodeIgniter\Router\RouteCollection;

/**
 * @var RouteCollection $routes
 */
$routes->get('/', 'Home::index');
$routes->get('/api/hello', 'Home::apiHello');
$routes->post('/api/echo', 'Home::echo');
$routes->get('/health', 'Home::health');
```

### app/Views/welcome_message.php

```php
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Hello World CodeIgniter</title>
    <style>
        body { font-family: Arial, sans-serif; text-align: center; background: #f8f9fa; }
        .container { max-width: 800px; margin: 50px auto; padding: 20px; }
        .card { background: white; border-radius: 8px; padding: 30px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .btn { background: #dc3545; color: white; padding: 10px 20px; text-decoration: none; border-radius: 4px; }
    </style>
</head>
<body>
    <div class="container">
        <div class="card">
            <h1><?= $message ?></h1>
            <p>Welcome to your CodeIgniter 4 application</p>
            <p>Current time: <?= $timestamp ?></p>
            <p>CodeIgniter Framework</p>

            <div style="margin-top: 30px;">
                <a href="/api/hello" class="btn">Test API</a>
                <a href="/health" class="btn">Health Check</a>
            </div>
        </div>
    </div>
</body>
</html>
```

### Dockerfile

```dockerfile
FROM php:8.3-apache

# Install dependencies
RUN apt-get update && apt-get install -y \
    libicu-dev \
    libzip-dev \
    unzip

# Install PHP extensions
RUN docker-php-ext-install intl zip pdo_mysql

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Enable Apache rewrite module
RUN a2enmod rewrite

WORKDIR /var/www/html

# Copy application
COPY . .

# Install dependencies (if using Composer)
RUN if [ -f composer.json ]; then composer install --optimize-autoloader --no-dev; fi

# Set permissions
RUN chown -R www-data:www-data /var/www/html

EXPOSE 80
CMD ["apache2-foreground"]
```

## 6. WordPress Application

### wp-config.php

```php
<?php
define('DB_NAME', getenv('WORDPRESS_DB_NAME') ?: 'wordpress');
define('DB_USER', getenv('WORDPRESS_DB_USER') ?: 'wordpress');
define('DB_PASSWORD', getenv('WORDPRESS_DB_PASSWORD') ?: 'password');
define('DB_HOST', getenv('WORDPRESS_DB_HOST') ?: 'mysql');
define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');

// Authentication Unique Keys and Salts
define('AUTH_KEY',         'your-auth-key-here');
define('SECURE_AUTH_KEY',  'your-secure-auth-key-here');
define('LOGGED_IN_KEY',    'your-logged-in-key-here');
define('NONCE_KEY',        'your-nonce-key-here');

$table_prefix = 'wp_';
define('WP_DEBUG', false);

if (!defined('ABSPATH')) {
    define('ABSPATH', __DIR__ . '/');
}

require_once ABSPATH . 'wp-settings.php';
?>
```

### themes/hello-world/index.php

```php
<!DOCTYPE html>
<html <?php language_attributes(); ?>>
<head>
    <meta charset="<?php bloginfo('charset'); ?>">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Hello World WordPress</title>
    <?php wp_head(); ?>
    <style>
        body { font-family: Arial, sans-serif; text-align: center; background: #f8f9fa; margin: 0; padding: 50px; }
        .container { max-width: 800px; margin: 0 auto; }
        .card { background: white; border-radius: 8px; padding: 30px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
    </style>
</head>
<body <?php body_class(); ?>>
    <div class="container">
        <div class="card">
            <h1>Hello World from WordPress!</h1>
            <p>Welcome to your WordPress site</p>
            <p>Site URL: <?php echo home_url(); ?></p>
            <p>WordPress Version: <?php echo get_bloginfo('version'); ?></p>
            <p>Current time: <?php echo current_time('Y-m-d H:i:s'); ?></p>

            <?php if (have_posts()) : ?>
                <h2>Recent Posts</h2>
                <?php while (have_posts()) : the_post(); ?>
                    <div style="margin: 20px 0; padding: 20px; border: 1px solid #ddd;">
                        <h3><a href="<?php the_permalink(); ?>"><?php the_title(); ?></a></h3>
                        <p><?php the_excerpt(); ?></p>
                    </div>
                <?php endwhile; ?>
            <?php endif; ?>
        </div>
    </div>
    <?php wp_footer(); ?>
</body>
</html>
```

### Dockerfile

```dockerfile
FROM wordpress:6.4-php8.3-apache

# Install additional PHP extensions if needed
RUN docker-php-ext-install mysqli pdo_mysql

# Copy custom theme
COPY themes/hello-world /var/www/html/wp-content/themes/hello-world

# Copy custom wp-config if needed
COPY wp-config.php /var/www/html/

# Set proper permissions
RUN chown -R www-data:www-data /var/www/html

EXPOSE 80
CMD ["apache2-foreground"]
```

## 7. API with Slim Framework

### composer.json

```json
{
  "require": {
    "slim/slim": "^4.0",
    "slim/psr7": "^1.6",
    "slim/http": "^1.3"
  },
  "autoload": {
    "psr-4": {
      "App\\": "src/"
    }
  }
}
```

### public/index.php

```php
<?php
require __DIR__ . '/../vendor/autoload.php';

use Slim\Factory\AppFactory;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

$app = AppFactory::create();

// Add error middleware
$app->addErrorMiddleware(true, true, true);

// Routes
$app->get('/', function (Request $request, Response $response) {
    $data = [
        'message' => 'Hello World from Slim Framework!',
        'timestamp' => date('Y-m-d H:i:s'),
        'framework' => 'Slim'
    ];

    $response->getBody()->write(json_encode($data));
    return $response->withHeader('Content-Type', 'application/json');
});

$app->get('/api/hello', function (Request $request, Response $response) {
    $data = [
        'message' => 'Hello World from Slim API!',
        'timestamp' => date('Y-m-d H:i:s'),
        'framework' => 'Slim Framework'
    ];

    $response->getBody()->write(json_encode($data));
    return $response->withHeader('Content-Type', 'application/json');
});

$app->post('/api/echo', function (Request $request, Response $response) {
    $body = $request->getBody()->getContents();
    $data = json_decode($body, true);

    $responseData = [
        'echo' => 'You said: ' . ($data['message'] ?? 'No message provided'),
        'timestamp' => date('Y-m-d H:i:s')
    ];

    $response->getBody()->write(json_encode($responseData));
    return $response->withHeader('Content-Type', 'application/json');
});

$app->get('/health', function (Request $request, Response $response) {
    $data = [
        'status' => 'healthy',
        'framework' => 'Slim',
        'php_version' => phpversion()
    ];

    $response->getBody()->write(json_encode($data));
    return $response->withHeader('Content-Type', 'application/json');
});

$app->run();
```

### Dockerfile

```dockerfile
FROM php:8.3-apache

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Enable Apache rewrite module
RUN a2enmod rewrite

# Set document root
ENV APACHE_DOCUMENT_ROOT /var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

WORKDIR /var/www/html

# Copy application
COPY . .

# Install dependencies
RUN composer install --optimize-autoloader --no-dev

# Set permissions
RUN chown -R www-data:www-data /var/www/html

EXPOSE 80
CMD ["apache2-foreground"]
```

## 8. CakePHP Application

### src/Controller/HelloController.php

```php
<?php
namespace App\Controller;

use Cake\Controller\Controller;

class HelloController extends Controller
{
    public function initialize(): void
    {
        parent::initialize();
        $this->loadComponent('RequestHandler');
    }

    public function index()
    {
        $this->set([
            'message' => 'Hello World from CakePHP!',
            'timestamp' => date('Y-m-d H:i:s')
        ]);
    }

    public function apiHello()
    {
        $this->viewBuilder()->setClassName('Json');

        $this->set([
            'message' => 'Hello World from CakePHP API!',
            'timestamp' => date('Y-m-d H:i:s'),
            'framework' => 'CakePHP'
        ]);
        $this->viewBuilder()->setOption('serialize', ['message', 'timestamp', 'framework']);
    }

    public function echo()
    {
        $this->viewBuilder()->setClassName('Json');
        $this->request->allowMethod(['post']);

        $data = $this->request->getData();

        $this->set([
            'echo' => 'You said: ' . ($data['message'] ?? 'No message provided'),
            'timestamp' => date('Y-m-d H:i:s')
        ]);
        $this->viewBuilder()->setOption('serialize', ['echo', 'timestamp']);
    }

    public function health()
    {
        $this->viewBuilder()->setClassName('Json');

        $this->set([
            'status' => 'healthy',
            'framework' => 'CakePHP',
            'php_version' => phpversion()
        ]);
        $this->viewBuilder()->setOption('serialize', ['status', 'framework', 'php_version']);
    }
}
```

### templates/Hello/index.php

```php
<!DOCTYPE html>
<html>
<head>
    <title>Hello World CakePHP</title>
    <style>
        body { font-family: Arial, sans-serif; text-align: center; background: #f8f9fa; }
        .container { max-width: 800px; margin: 50px auto; padding: 20px; }
        .card { background: white; border-radius: 8px; padding: 30px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .btn { background: #dc3545; color: white; padding: 10px 20px; text-decoration: none; border-radius: 4px; }
    </style>
</head>
<body>
    <div class="container">
        <div class="card">
            <h1><?= h($message) ?></h1>
            <p>Welcome to your CakePHP application</p>
            <p>Current time: <?= h($timestamp) ?></p>
            <p>CakePHP Framework</p>

            <div style="margin-top: 30px;">
                <a href="/hello/api-hello" class="btn">Test API</a>
                <a href="/hello/health" class="btn">Health Check</a>
            </div>
        </div>
    </div>
</body>
</html>
```

### Dockerfile

```dockerfile
FROM php:8.3-apache

# Install dependencies
RUN apt-get update && apt-get install -y \
    libicu-dev \
    libzip-dev \
    unzip

# Install PHP extensions
RUN docker-php-ext-install intl zip pdo_mysql

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Enable Apache rewrite module
RUN a2enmod rewrite

WORKDIR /var/www/html

# Copy application
COPY . .

# Install dependencies
RUN composer install --optimize-autoloader --no-dev

# Set permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html/tmp \
    && chmod -R 755 /var/www/html/logs

EXPOSE 80
CMD ["apache2-foreground"]
```

## 9. Pure PHP REST API

### public/index.php

```php
<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

class SimpleAPI {
    private $data = [
        ['id' => 1, 'name' => 'Hello World User', 'email' => 'hello@world.com'],
        ['id' => 2, 'name' => 'PHP User', 'email' => 'php@user.com']
    ];

    public function handleRequest() {
        $method = $_SERVER['REQUEST_METHOD'];
        $path = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);
        $path = trim($path, '/');

        switch ($path) {
            case '':
                $this->home();
                break;
            case 'api/hello':
                $this->hello();
                break;
            case 'api/users':
                if ($method === 'GET') {
                    $this->getUsers();
                } elseif ($method === 'POST') {
                    $this->createUser();
                }
                break;
            case 'health':
                $this->health();
                break;
            default:
                $this->notFound();
        }
    }

    private function home() {
        echo json_encode([
            'message' => 'Hello World from Pure PHP API!',
            'timestamp' => date('Y-m-d H:i:s'),
            'endpoints' => [
                'GET /' => 'This message',
                'GET /api/hello' => 'Hello endpoint',
                'GET /api/users' => 'Get all users',
                'POST /api/users' => 'Create user',
                'GET /health' => 'Health check'
            ]
        ]);
    }

    private function hello() {
        echo json_encode([
            'message' => 'Hello World from PHP API!',
            'timestamp' => date('Y-m-d H:i:s'),
            'framework' => 'Pure PHP'
        ]);
    }

    private function getUsers() {
        echo json_encode([
            'users' => $this->data,
            'count' => count($this->data)
        ]);
    }

    private function createUser() {
        $input = json_decode(file_get_contents('php://input'), true);

        $newUser = [
            'id' => count($this->data) + 1,
            'name' => $input['name'] ?? 'Unknown',
            'email' => $input['email'] ?? 'unknown@email.com'
        ];

        $this->data[] = $newUser;

        echo json_encode([
            'message' => 'User created successfully',
            'user' => $newUser
        ]);
    }

    private function health() {
        echo json_encode([
            'status' => 'healthy',
            'framework' => 'Pure PHP',
            'php_version' => phpversion(),
            'timestamp' => date('Y-m-d H:i:s')
        ]);
    }

    private function notFound() {
        http_response_code(404);
        echo json_encode(['error' => 'Endpoint not found']);
    }
}

$api = new SimpleAPI();
$api->handleRequest();
?>
```

### Dockerfile

```dockerfile
FROM php:8.3-apache

# Enable Apache rewrite module
RUN a2enmod rewrite

# Set document root
ENV APACHE_DOCUMENT_ROOT /var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

WORKDIR /var/www/html

# Copy application
COPY . .

# Set permissions
RUN chown -R www-data:www-data /var/www/html

EXPOSE 80
CMD ["apache2-foreground"]
```

## Docker Compose Examples

### Laravel + MySQL + Redis

```yaml
version: "3.8"
services:
  app:
    build: ./laravel-app
    ports:
      - "8080:80"
    environment:
      - DB_CONNECTION=mysql
      - DB_HOST=mysql
      - DB_DATABASE=laravel
      - DB_USERNAME=laravel
      - DB_PASSWORD=password
      - REDIS_HOST=redis
    depends_on:
      - mysql
      - redis
    volumes:
      - ./laravel-app:/var/www/html

  mysql:
    image: mysql:8.0
    environment:
      MYSQL_ROOT_PASSWORD: rootpassword
      MYSQL_DATABASE: laravel
      MYSQL_USER: laravel
      MYSQL_PASSWORD: password
    volumes:
      - mysql_data:/var/lib/mysql

  redis:
    image: redis:alpine

volumes:
  mysql_data:
```

### WordPress + MySQL

```yaml
version: "3.8"
services:
  wordpress:
    build: ./wordpress
    ports:
      - "8080:80"
    environment:
      WORDPRESS_DB_HOST: mysql
      WORDPRESS_DB_NAME: wordpress
      WORDPRESS_DB_USER: wordpress
      WORDPRESS_DB_PASSWORD: password
    depends_on:
      - mysql
    volumes:
      - wordpress_data:/var/www/html

  mysql:
    image: mysql:8.0
    environment:
      MYSQL_ROOT_PASSWORD: rootpassword
      MYSQL_DATABASE: wordpress
      MYSQL_USER: wordpress
      MYSQL_PASSWORD: password
    volumes:
      - mysql_data:/var/lib/mysql

volumes:
  wordpress_data:
  mysql_data:
```

### Multi-Framework Setup

```yaml
version: "3.8"
services:
  laravel:
    build: ./laravel-app
    ports:
      - "8081:80"

  symfony:
    build: ./symfony-app
    ports:
      - "8082:80"

  codeigniter:
    build: ./codeigniter-app
    ports:
      - "8083:80"

  slim-api:
    build: ./slim-api
    ports:
      - "8084:80"

  nginx:
    image: nginx:alpine
    ports:
      - "8080:80"
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf
    depends_on:
      - laravel
      - symfony
      - codeigniter
      - slim-api
```

## Production Optimizations

### Multi-stage Build

```dockerfile
FROM composer:2.6 AS composer
WORKDIR /app
COPY composer.json composer.lock ./
RUN composer install --optimize-autoloader --no-dev --no-scripts

FROM php:8.3-fpm-alpine AS production
RUN apk add --no-cache nginx supervisor

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql opcache

# Copy application
WORKDIR /var/www/html
COPY . .
COPY --from=composer /app/vendor ./vendor

# Optimize for production
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Configure PHP for production
COPY php.ini /usr/local/etc/php/conf.d/custom.ini

EXPOSE 80
CMD ["supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
```

### .dockerignore

```
.git
.gitignore
README.md
.env
.env.local
.env.*.local
node_modules/
npm-debug.log*
yarn-debug.log*
yarn-error.log*
.DS_Store
Thumbs.db
vendor/
storage/logs/*
storage/framework/cache/*
storage/framework/sessions/*
storage/framework/views/*
bootstrap/cache/*
```

### Health Check

```dockerfile
FROM php:8.3-apache
WORKDIR /var/www/html
COPY . .
EXPOSE 80
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost/health || exit 1
CMD ["apache2-foreground"]
```

Tất cả các project PHP trên đều có thể build và chạy với Docker. Mỗi project đại diện cho một pattern phổ biến trong PHP development, từ web frameworks đến CMS và APIs.
