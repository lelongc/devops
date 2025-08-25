# Node.js Projects with Docker

Tổng hợp các loại project Node.js phổ biến với Dockerfile tương ứng.

## 1. Basic Node.js Application

### Package.json

```json
{
  "name": "basic-nodejs",
  "version": "1.0.0",
  "main": "index.js",
  "scripts": {
    "start": "node index.js"
  }
}
```

### index.js

```javascript
console.log("Hello World from Basic Node.js!");
```

### Dockerfile

```dockerfile
FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 3000
CMD ["npm", "start"]
```

## 2. Express.js Web Server

### Package.json

```json
{
  "name": "express-app",
  "version": "1.0.0",
  "main": "app.js",
  "scripts": {
    "start": "node app.js"
  },
  "dependencies": {
    "express": "^4.18.0"
  }
}
```

### app.js

```javascript
const express = require("express");
const app = express();
const port = 3000;

app.get("/", (req, res) => {
  res.send("Hello World from Express!");
});

app.listen(port, () => {
  console.log(`Express app listening at http://localhost:${port}`);
});
```

### Dockerfile

```dockerfile
FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 3000
CMD ["npm", "start"]
```

## 3. Next.js Application

### Package.json

```json
{
  "name": "nextjs-app",
  "version": "1.0.0",
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start"
  },
  "dependencies": {
    "next": "^14.0.0",
    "react": "^18.0.0",
    "react-dom": "^18.0.0"
  }
}
```

### pages/index.js

```javascript
export default function Home() {
  return <h1>Hello World from Next.js!</h1>;
}
```

### Dockerfile

```dockerfile
FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build
EXPOSE 3000
CMD ["npm", "start"]
```

## 4. Nest.js Application

### Package.json

```json
{
  "name": "nestjs-app",
  "version": "1.0.0",
  "scripts": {
    "start": "nest start",
    "build": "nest build"
  },
  "dependencies": {
    "@nestjs/core": "^10.0.0",
    "@nestjs/common": "^10.0.0",
    "@nestjs/platform-express": "^10.0.0"
  }
}
```

### src/main.ts

```typescript
import { NestFactory } from "@nestjs/core";
import { AppModule } from "./app.module";

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  await app.listen(3000);
  console.log("Hello World from NestJS!");
}
bootstrap();
```

### Dockerfile

```dockerfile
FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build
EXPOSE 3000
CMD ["npm", "run", "start:prod"]
```

## 5. Fastify Application

### Package.json

```json
{
  "name": "fastify-app",
  "version": "1.0.0",
  "main": "server.js",
  "scripts": {
    "start": "node server.js"
  },
  "dependencies": {
    "fastify": "^4.0.0"
  }
}
```

### server.js

```javascript
const fastify = require("fastify")({ logger: true });

fastify.get("/", async (request, reply) => {
  return { message: "Hello World from Fastify!" };
});

const start = async () => {
  try {
    await fastify.listen({ port: 3000, host: "0.0.0.0" });
    console.log("Fastify server running on port 3000");
  } catch (err) {
    fastify.log.error(err);
    process.exit(1);
  }
};
start();
```

### Dockerfile

```dockerfile
FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 3000
CMD ["npm", "start"]
```

## 6. Koa.js Application

### Package.json

```json
{
  "name": "koa-app",
  "version": "1.0.0",
  "main": "app.js",
  "scripts": {
    "start": "node app.js"
  },
  "dependencies": {
    "koa": "^2.14.0"
  }
}
```

### app.js

```javascript
const Koa = require("koa");
const app = new Koa();

app.use(async (ctx) => {
  ctx.body = "Hello World from Koa!";
});

app.listen(3000, () => {
  console.log("Koa server running on port 3000");
});
```

### Dockerfile

```dockerfile
FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 3000
CMD ["npm", "start"]
```

## 7. Socket.io Application

### Package.json

```json
{
  "name": "socketio-app",
  "version": "1.0.0",
  "main": "server.js",
  "scripts": {
    "start": "node server.js"
  },
  "dependencies": {
    "socket.io": "^4.7.0",
    "express": "^4.18.0"
  }
}
```

### server.js

```javascript
const express = require("express");
const { createServer } = require("http");
const { Server } = require("socket.io");

const app = express();
const server = createServer(app);
const io = new Server(server);

app.get("/", (req, res) => {
  res.send("<h1>Hello World from Socket.io!</h1>");
});

io.on("connection", (socket) => {
  console.log("A user connected");
  socket.emit("message", "Hello from Socket.io server!");
});

server.listen(3000, () => {
  console.log("Socket.io server running on port 3000");
});
```

### Dockerfile

```dockerfile
FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 3000
CMD ["npm", "start"]
```

## 8. GraphQL with Apollo Server

### Package.json

```json
{
  "name": "graphql-app",
  "version": "1.0.0",
  "main": "server.js",
  "scripts": {
    "start": "node server.js"
  },
  "dependencies": {
    "apollo-server-express": "^3.12.0",
    "express": "^4.18.0",
    "graphql": "^16.0.0"
  }
}
```

### server.js

```javascript
const express = require("express");
const { ApolloServer, gql } = require("apollo-server-express");

const typeDefs = gql`
  type Query {
    hello: String
  }
`;

const resolvers = {
  Query: {
    hello: () => "Hello World from GraphQL!",
  },
};

async function startServer() {
  const app = express();
  const server = new ApolloServer({ typeDefs, resolvers });

  await server.start();
  server.applyMiddleware({ app });

  app.listen(3000, () => {
    console.log(
      `GraphQL server ready at http://localhost:3000${server.graphqlPath}`
    );
  });
}

startServer();
```

### Dockerfile

```dockerfile
FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 3000
CMD ["npm", "start"]
```

## 9. REST API with Express + MongoDB

### Package.json

```json
{
  "name": "rest-api-mongo",
  "version": "1.0.0",
  "main": "server.js",
  "scripts": {
    "start": "node server.js"
  },
  "dependencies": {
    "express": "^4.18.0",
    "mongoose": "^7.0.0",
    "cors": "^2.8.5"
  }
}
```

### server.js

```javascript
const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");

const app = express();
app.use(cors());
app.use(express.json());

// Simple in-memory data for demo
let users = [{ id: 1, name: "Hello World User" }];

app.get("/api/users", (req, res) => {
  res.json(users);
});

app.get("/", (req, res) => {
  res.send("Hello World from REST API!");
});

app.listen(3000, () => {
  console.log("REST API server running on port 3000");
});
```

### Dockerfile

```dockerfile
FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 3000
CMD ["npm", "start"]
```

## 10. TypeScript Node.js Application

### Package.json

```json
{
  "name": "typescript-app",
  "version": "1.0.0",
  "main": "dist/index.js",
  "scripts": {
    "build": "tsc",
    "start": "node dist/index.js",
    "dev": "ts-node src/index.ts"
  },
  "dependencies": {
    "express": "^4.18.0"
  },
  "devDependencies": {
    "@types/express": "^4.17.0",
    "@types/node": "^20.0.0",
    "typescript": "^5.0.0",
    "ts-node": "^10.9.0"
  }
}
```

### src/index.ts

```typescript
import express from "express";

const app = express();
const port = 3000;

app.get("/", (req, res) => {
  res.send("Hello World from TypeScript!");
});

app.listen(port, () => {
  console.log(`TypeScript app listening at http://localhost:${port}`);
});
```

### tsconfig.json

```json
{
  "compilerOptions": {
    "target": "ES2020",
    "module": "commonjs",
    "outDir": "./dist",
    "rootDir": "./src",
    "strict": true,
    "esModuleInterop": true
  }
}
```

### Dockerfile

```dockerfile
FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
COPY tsconfig.json ./
RUN npm install
COPY src ./src
RUN npm run build
EXPOSE 3000
CMD ["npm", "start"]
```

## 11. Microservice với Redis

### Package.json

```json
{
  "name": "microservice-redis",
  "version": "1.0.0",
  "main": "server.js",
  "scripts": {
    "start": "node server.js"
  },
  "dependencies": {
    "express": "^4.18.0",
    "redis": "^4.6.0"
  }
}
```

### server.js

```javascript
const express = require("express");
const redis = require("redis");

const app = express();
const client = redis.createClient({
  host: process.env.REDIS_HOST || "localhost",
  port: process.env.REDIS_PORT || 6379,
});

app.get("/", async (req, res) => {
  try {
    await client.set("message", "Hello World from Microservice with Redis!");
    const message = await client.get("message");
    res.json({ message });
  } catch (error) {
    res.json({ message: "Hello World from Microservice!" });
  }
});

app.listen(3000, () => {
  console.log("Microservice running on port 3000");
});
```

### Dockerfile

```dockerfile
FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 3000
CMD ["npm", "start"]
```

## 12. WebSocket Server

### Package.json

```json
{
  "name": "websocket-server",
  "version": "1.0.0",
  "main": "server.js",
  "scripts": {
    "start": "node server.js"
  },
  "dependencies": {
    "ws": "^8.14.0"
  }
}
```

### server.js

```javascript
const WebSocket = require("ws");

const wss = new WebSocket.Server({ port: 3000 });

wss.on("connection", function connection(ws) {
  console.log("Client connected");

  ws.send("Hello World from WebSocket Server!");

  ws.on("message", function incoming(message) {
    console.log("received: %s", message);
    ws.send(`Echo: ${message}`);
  });

  ws.on("close", function close() {
    console.log("Client disconnected");
  });
});

console.log("WebSocket server running on port 3000");
```

### Dockerfile

```dockerfile
FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 3000
CMD ["npm", "start"]
```

## Docker Compose Examples

### Basic Multi-Service Setup

```yaml
version: "3.8"
services:
  express-app:
    build: ./express-app
    ports:
      - "3001:3000"

  nextjs-app:
    build: ./nextjs-app
    ports:
      - "3002:3000"

  api-service:
    build: ./rest-api-mongo
    ports:
      - "3003:3000"
    depends_on:
      - mongodb

  mongodb:
    image: mongo:latest
    ports:
      - "27017:27017"

  redis:
    image: redis:alpine
    ports:
      - "6379:6379"
```

### Production-Ready Setup

```yaml
version: "3.8"
services:
  app:
    build:
      context: .
      dockerfile: Dockerfile.prod
    restart: unless-stopped
    environment:
      - NODE_ENV=production
    ports:
      - "80:3000"
    depends_on:
      - db
      - redis

  db:
    image: postgres:15-alpine
    restart: unless-stopped
    environment:
      POSTGRES_DB: myapp
      POSTGRES_USER: user
      POSTGRES_PASSWORD: password
    volumes:
      - postgres_data:/var/lib/postgresql/data

  redis:
    image: redis:alpine
    restart: unless-stopped

volumes:
  postgres_data:
```

## Optimization Tips

### Multi-stage Dockerfile

```dockerfile
# Build stage
FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production

# Production stage
FROM node:18-alpine AS production
WORKDIR /app
COPY --from=builder /app/node_modules ./node_modules
COPY . .
EXPOSE 3000
USER node
CMD ["npm", "start"]
```

### .dockerignore

```
node_modules
npm-debug.log
.git
.gitignore
README.md
.env
.nyc_output
coverage
.cache
```

Tất cả các project trên đều có thể build và chạy với Docker. Mỗi project đại diện cho một pattern phổ biến trong Node.js development.
