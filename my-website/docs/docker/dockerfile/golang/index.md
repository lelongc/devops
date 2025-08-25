# Go (Golang) Projects with Docker

Tổng hợp các loại project Go phổ biến với Dockerfile tương ứng.

## 1. Basic Go Application

### main.go

```go
package main

import (
    "fmt"
    "time"
)

func main() {
    fmt.Println("Hello World from Go!")
    fmt.Println("Basic Go application is running...")

    // Keep running
    for {
        fmt.Printf("Current time: %s\n", time.Now().Format("2006-01-02 15:04:05"))
        time.Sleep(10 * time.Second)
    }
}
```

### go.mod

```go
module hello-world

go 1.21
```

### Dockerfile

```dockerfile
FROM golang:1.21-alpine AS build
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN go build -o main .

FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=build /app/main .
CMD ["./main"]
```

## 2. Gin Web Framework

### go.mod

```go
module gin-app

go 1.21

require github.com/gin-gonic/gin v1.9.1
```

### main.go

```go
package main

import (
    "net/http"
    "github.com/gin-gonic/gin"
)

type Response struct {
    Message string `json:"message"`
    Status  string `json:"status,omitempty"`
}

func main() {
    // Set Gin to release mode in production
    gin.SetMode(gin.ReleaseMode)

    r := gin.Default()

    r.GET("/", func(c *gin.Context) {
        c.JSON(http.StatusOK, Response{
            Message: "Hello World from Gin!",
        })
    })

    r.GET("/health", func(c *gin.Context) {
        c.JSON(http.StatusOK, Response{
            Message: "Gin server is healthy",
            Status:  "UP",
        })
    })

    r.POST("/echo", func(c *gin.Context) {
        var request Response
        if err := c.ShouldBindJSON(&request); err != nil {
            c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
            return
        }

        c.JSON(http.StatusOK, Response{
            Message: "Echo: " + request.Message,
        })
    })

    r.Run(":8080")
}
```

### Dockerfile

```dockerfile
FROM golang:1.21-alpine AS build
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .

FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=build /app/main .
EXPOSE 8080
CMD ["./main"]
```

## 3. Echo Web Framework

### go.mod

```go
module echo-app

go 1.21

require github.com/labstack/echo/v4 v4.11.3
```

### main.go

```go
package main

import (
    "net/http"
    "github.com/labstack/echo/v4"
    "github.com/labstack/echo/v4/middleware"
)

type Response struct {
    Message string `json:"message"`
    Status  string `json:"status,omitempty"`
}

func main() {
    e := echo.New()

    // Middleware
    e.Use(middleware.Logger())
    e.Use(middleware.Recover())
    e.Use(middleware.CORS())

    // Routes
    e.GET("/", helloWorld)
    e.GET("/health", healthCheck)
    e.POST("/echo", echoMessage)

    e.Logger.Fatal(e.Start(":8080"))
}

func helloWorld(c echo.Context) error {
    return c.JSON(http.StatusOK, Response{
        Message: "Hello World from Echo!",
    })
}

func healthCheck(c echo.Context) error {
    return c.JSON(http.StatusOK, Response{
        Message: "Echo server is healthy",
        Status:  "UP",
    })
}

func echoMessage(c echo.Context) error {
    var request Response
    if err := c.Bind(&request); err != nil {
        return c.JSON(http.StatusBadRequest, map[string]string{"error": err.Error()})
    }

    return c.JSON(http.StatusOK, Response{
        Message: "Echo: " + request.Message,
    })
}
```

### Dockerfile

```dockerfile
FROM golang:1.21-alpine AS build
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .

FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=build /app/main .
EXPOSE 8080
CMD ["./main"]
```

## 4. Fiber Web Framework

### go.mod

```go
module fiber-app

go 1.21

require github.com/gofiber/fiber/v2 v2.51.0
```

### main.go

```go
package main

import (
    "log"
    "github.com/gofiber/fiber/v2"
    "github.com/gofiber/fiber/v2/middleware/cors"
    "github.com/gofiber/fiber/v2/middleware/logger"
)

type Response struct {
    Message string `json:"message"`
    Status  string `json:"status,omitempty"`
}

func main() {
    app := fiber.New(fiber.Config{
        Prefork: false, // Disable in development
    })

    // Middleware
    app.Use(logger.New())
    app.Use(cors.New())

    // Routes
    app.Get("/", func(c *fiber.Ctx) error {
        return c.JSON(Response{
            Message: "Hello World from Fiber!",
        })
    })

    app.Get("/health", func(c *fiber.Ctx) error {
        return c.JSON(Response{
            Message: "Fiber server is healthy",
            Status:  "UP",
        })
    })

    app.Post("/echo", func(c *fiber.Ctx) error {
        var request Response
        if err := c.BodyParser(&request); err != nil {
            return c.Status(400).JSON(fiber.Map{"error": err.Error()})
        }

        return c.JSON(Response{
            Message: "Echo: " + request.Message,
        })
    })

    log.Fatal(app.Listen(":8080"))
}
```

### Dockerfile

```dockerfile
FROM golang:1.21-alpine AS build
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .

FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=build /app/main .
EXPOSE 8080
CMD ["./main"]
```

## 5. gRPC Server

### go.mod

```go
module grpc-app

go 1.21

require (
    google.golang.org/grpc v1.59.0
    google.golang.org/protobuf v1.31.0
)
```

### proto/hello.proto

```protobuf
syntax = "proto3";

package hello;

option go_package = "./hello";

service HelloService {
  rpc SayHello(HelloRequest) returns (HelloResponse);
  rpc SayHelloStream(HelloRequest) returns (stream HelloResponse);
}

message HelloRequest {
  string name = 1;
}

message HelloResponse {
  string message = 1;
}
```

### main.go

```go
package main

import (
    "context"
    "fmt"
    "log"
    "net"
    "time"

    "google.golang.org/grpc"
    pb "./hello" // Generated protobuf code
)

type server struct {
    pb.UnimplementedHelloServiceServer
}

func (s *server) SayHello(ctx context.Context, req *pb.HelloRequest) (*pb.HelloResponse, error) {
    message := fmt.Sprintf("Hello World from gRPC! Hi %s", req.GetName())
    return &pb.HelloResponse{Message: message}, nil
}

func (s *server) SayHelloStream(req *pb.HelloRequest, stream pb.HelloService_SayHelloStreamServer) error {
    for i := 0; i < 5; i++ {
        message := fmt.Sprintf("Hello World from gRPC Stream! Hi %s - Message %d", req.GetName(), i+1)
        if err := stream.Send(&pb.HelloResponse{Message: message}); err != nil {
            return err
        }
        time.Sleep(1 * time.Second)
    }
    return nil
}

func main() {
    lis, err := net.Listen("tcp", ":50051")
    if err != nil {
        log.Fatalf("Failed to listen: %v", err)
    }

    s := grpc.NewServer()
    pb.RegisterHelloServiceServer(s, &server{})

    fmt.Println("gRPC server listening on :50051")
    if err := s.Serve(lis); err != nil {
        log.Fatalf("Failed to serve: %v", err)
    }
}
```

### Dockerfile

```dockerfile
FROM golang:1.21-alpine AS build
WORKDIR /app

# Install protobuf compiler
RUN apk add --no-cache protobuf-dev
RUN go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
RUN go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest

COPY go.mod go.sum ./
RUN go mod download
COPY . .

# Generate protobuf code
RUN protoc --go_out=. --go-grpc_out=. proto/*.proto

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .

FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=build /app/main .
EXPOSE 50051
CMD ["./main"]
```

## 6. REST API with GORM and PostgreSQL

### go.mod

```go
module rest-api

go 1.21

require (
    github.com/gin-gonic/gin v1.9.1
    gorm.io/gorm v1.25.5
    gorm.io/driver/postgres v1.5.4
)
```

### models/user.go

```go
package models

import (
    "gorm.io/gorm"
)

type User struct {
    ID    uint   `json:"id" gorm:"primaryKey"`
    Name  string `json:"name" gorm:"not null"`
    Email string `json:"email" gorm:"uniqueIndex;not null"`
}

type Database struct {
    DB *gorm.DB
}

func (db *Database) CreateUser(user *User) error {
    return db.DB.Create(user).Error
}

func (db *Database) GetUsers() ([]User, error) {
    var users []User
    err := db.DB.Find(&users).Error
    return users, err
}

func (db *Database) GetUserByID(id uint) (User, error) {
    var user User
    err := db.DB.First(&user, id).Error
    return user, err
}
```

### main.go

```go
package main

import (
    "net/http"
    "strconv"

    "github.com/gin-gonic/gin"
    "gorm.io/driver/postgres"
    "gorm.io/gorm"

    "./models"
)

var database models.Database

func main() {
    // Database connection
    dsn := "host=postgres user=user password=password dbname=myapp port=5432 sslmode=disable"
    db, err := gorm.Open(postgres.Open(dsn), &gorm.Config{})
    if err != nil {
        panic("Failed to connect to database")
    }

    // Auto migrate
    db.AutoMigrate(&models.User{})
    database = models.Database{DB: db}

    // Create sample data
    database.CreateUser(&models.User{Name: "Hello World User", Email: "hello@world.com"})

    r := gin.Default()

    r.GET("/", func(c *gin.Context) {
        c.JSON(http.StatusOK, gin.H{
            "message": "Hello World from Go REST API!",
        })
    })

    r.GET("/users", getUsers)
    r.GET("/users/:id", getUserByID)
    r.POST("/users", createUser)

    r.Run(":8080")
}

func getUsers(c *gin.Context) {
    users, err := database.GetUsers()
    if err != nil {
        c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
        return
    }
    c.JSON(http.StatusOK, users)
}

func getUserByID(c *gin.Context) {
    id, err := strconv.ParseUint(c.Param("id"), 10, 32)
    if err != nil {
        c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid ID"})
        return
    }

    user, err := database.GetUserByID(uint(id))
    if err != nil {
        c.JSON(http.StatusNotFound, gin.H{"error": "User not found"})
        return
    }

    c.JSON(http.StatusOK, user)
}

func createUser(c *gin.Context) {
    var user models.User
    if err := c.ShouldBindJSON(&user); err != nil {
        c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
        return
    }

    if err := database.CreateUser(&user); err != nil {
        c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
        return
    }

    c.JSON(http.StatusCreated, user)
}
```

### Dockerfile

```dockerfile
FROM golang:1.21-alpine AS build
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .

FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=build /app/main .
EXPOSE 8080
CMD ["./main"]
```

## 7. GraphQL API with gqlgen

### go.mod

```go
module graphql-app

go 1.21

require (
    github.com/99designs/gqlgen v0.17.41
    github.com/vektah/gqlparser/v2 v2.5.10
)
```

### schema.graphql

```graphql
type Query {
  hello(name: String!): String!
  users: [User!]!
}

type Mutation {
  createUser(input: NewUser!): User!
}

type User {
  id: ID!
  name: String!
  email: String!
}

input NewUser {
  name: String!
  email: String!
}
```

### resolver.go

```go
package main

import (
    "context"
    "fmt"
    "strconv"
)

type Resolver struct {
    users []User
    nextID int
}

type User struct {
    ID    string `json:"id"`
    Name  string `json:"name"`
    Email string `json:"email"`
}

type NewUser struct {
    Name  string `json:"name"`
    Email string `json:"email"`
}

func (r *Resolver) Query() QueryResolver {
    return &queryResolver{r}
}

func (r *Resolver) Mutation() MutationResolver {
    return &mutationResolver{r}
}

type queryResolver struct{ *Resolver }

func (r *queryResolver) Hello(ctx context.Context, name string) (string, error) {
    return fmt.Sprintf("Hello World from GraphQL! Hi %s", name), nil
}

func (r *queryResolver) Users(ctx context.Context) ([]*User, error) {
    result := make([]*User, len(r.users))
    for i, user := range r.users {
        result[i] = &user
    }
    return result, nil
}

type mutationResolver struct{ *Resolver }

func (r *mutationResolver) CreateUser(ctx context.Context, input NewUser) (*User, error) {
    user := User{
        ID:    strconv.Itoa(r.nextID),
        Name:  input.Name,
        Email: input.Email,
    }
    r.users = append(r.users, user)
    r.nextID++
    return &user, nil
}
```

### main.go

```go
package main

import (
    "log"
    "net/http"
    "os"

    "github.com/99designs/gqlgen/graphql/handler"
    "github.com/99designs/gqlgen/graphql/playground"
)

func main() {
    resolver := &Resolver{
        users: []User{
            {ID: "1", Name: "Hello World User", Email: "hello@world.com"},
        },
        nextID: 2,
    }

    srv := handler.NewDefaultServer(NewExecutableSchema(Config{Resolvers: resolver}))

    http.Handle("/", playground.Handler("GraphQL playground", "/query"))
    http.Handle("/query", srv)

    port := os.Getenv("PORT")
    if port == "" {
        port = "8080"
    }

    log.Printf("GraphQL server ready at http://localhost:%s/", port)
    log.Fatal(http.ListenAndServe(":"+port, nil))
}
```

### Dockerfile

```dockerfile
FROM golang:1.21-alpine AS build
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .

FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=build /app/main .
EXPOSE 8080
CMD ["./main"]
```

## 8. WebSocket Server with Gorilla

### go.mod

```go
module websocket-app

go 1.21

require github.com/gorilla/websocket v1.5.1
```

### main.go

```go
package main

import (
    "log"
    "net/http"
    "time"

    "github.com/gorilla/websocket"
)

var upgrader = websocket.Upgrader{
    CheckOrigin: func(r *http.Request) bool {
        return true // Allow all origins in demo
    },
}

type Hub struct {
    clients    map[*Client]bool
    broadcast  chan []byte
    register   chan *Client
    unregister chan *Client
}

type Client struct {
    hub  *Hub
    conn *websocket.Conn
    send chan []byte
}

func newHub() *Hub {
    return &Hub{
        clients:    make(map[*Client]bool),
        broadcast:  make(chan []byte),
        register:   make(chan *Client),
        unregister: make(chan *Client),
    }
}

func (h *Hub) run() {
    for {
        select {
        case client := <-h.register:
            h.clients[client] = true
            log.Println("Client connected")

        case client := <-h.unregister:
            if _, ok := h.clients[client]; ok {
                delete(h.clients, client)
                close(client.send)
                log.Println("Client disconnected")
            }

        case message := <-h.broadcast:
            for client := range h.clients {
                select {
                case client.send <- message:
                default:
                    close(client.send)
                    delete(h.clients, client)
                }
            }
        }
    }
}

func (c *Client) readPump() {
    defer func() {
        c.hub.unregister <- c
        c.conn.Close()
    }()

    for {
        _, message, err := c.conn.ReadMessage()
        if err != nil {
            break
        }

        // Echo message back with prefix
        response := "Echo: " + string(message)
        c.hub.broadcast <- []byte(response)
    }
}

func (c *Client) writePump() {
    defer c.conn.Close()

    for {
        select {
        case message, ok := <-c.send:
            if !ok {
                c.conn.WriteMessage(websocket.CloseMessage, []byte{})
                return
            }

            c.conn.WriteMessage(websocket.TextMessage, message)
        }
    }
}

func handleWebSocket(hub *Hub, w http.ResponseWriter, r *http.Request) {
    conn, err := upgrader.Upgrade(w, r, nil)
    if err != nil {
        log.Println(err)
        return
    }

    client := &Client{hub: hub, conn: conn, send: make(chan []byte, 256)}
    client.hub.register <- client

    // Send welcome message
    client.send <- []byte("Hello World from WebSocket Server!")

    go client.writePump()
    go client.readPump()
}

func main() {
    hub := newHub()
    go hub.run()

    // Broadcast hello messages periodically
    go func() {
        ticker := time.NewTicker(30 * time.Second)
        defer ticker.Stop()

        for {
            select {
            case <-ticker.C:
                hub.broadcast <- []byte("Periodic Hello World from WebSocket!")
            }
        }
    }()

    http.HandleFunc("/ws", func(w http.ResponseWriter, r *http.Request) {
        handleWebSocket(hub, w, r)
    })

    http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
        http.ServeFile(w, r, "index.html")
    })

    log.Println("WebSocket server starting on :8080")
    log.Fatal(http.ListenAndServe(":8080", nil))
}
```

### index.html

```html
<!DOCTYPE html>
<html>
  <head>
    <title>WebSocket Demo</title>
  </head>
  <body>
    <h1>Hello World WebSocket Demo</h1>
    <div id="messages"></div>
    <input type="text" id="messageInput" placeholder="Type a message..." />
    <button onclick="sendMessage()">Send</button>

    <script>
      const ws = new WebSocket("ws://localhost:8080/ws");
      const messages = document.getElementById("messages");

      ws.onmessage = function (event) {
        const div = document.createElement("div");
        div.textContent = event.data;
        messages.appendChild(div);
      };

      function sendMessage() {
        const input = document.getElementById("messageInput");
        ws.send(input.value);
        input.value = "";
      }
    </script>
  </body>
</html>
```

### Dockerfile

```dockerfile
FROM golang:1.21-alpine AS build
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .

FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=build /app/main .
COPY --from=build /app/index.html .
EXPOSE 8080
CMD ["./main"]
```

## 9. CLI Application with Cobra

### go.mod

```go
module cli-app

go 1.21

require github.com/spf13/cobra v1.8.0
```

### main.go

```go
package main

import (
    "fmt"
    "os"

    "github.com/spf13/cobra"
)

var rootCmd = &cobra.Command{
    Use:   "hello",
    Short: "A Hello World CLI application",
    Long:  "A simple CLI application that demonstrates Hello World functionality",
    Run: func(cmd *cobra.Command, args []string) {
        fmt.Println("Hello World from Go CLI!")
    },
}

var helloCmd = &cobra.Command{
    Use:   "greet [name]",
    Short: "Greet someone",
    Args:  cobra.MinimumNArgs(1),
    Run: func(cmd *cobra.Command, args []string) {
        name := args[0]
        fmt.Printf("Hello World, %s!\n", name)
    },
}

var versionCmd = &cobra.Command{
    Use:   "version",
    Short: "Print the version number",
    Run: func(cmd *cobra.Command, args []string) {
        fmt.Println("Hello World CLI v1.0.0")
    },
}

func init() {
    rootCmd.AddCommand(helloCmd)
    rootCmd.AddCommand(versionCmd)
}

func main() {
    if err := rootCmd.Execute(); err != nil {
        fmt.Println(err)
        os.Exit(1)
    }
}
```

### Dockerfile

```dockerfile
FROM golang:1.21-alpine AS build
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o hello .

FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=build /app/hello .
ENTRYPOINT ["./hello"]
CMD ["--help"]
```

## 10. Microservice with Redis

### go.mod

```go
module microservice-redis

go 1.21

require (
    github.com/gin-gonic/gin v1.9.1
    github.com/go-redis/redis/v8 v8.11.5
)
```

### main.go

```go
package main

import (
    "context"
    "net/http"
    "time"

    "github.com/gin-gonic/gin"
    "github.com/go-redis/redis/v8"
)

var rdb *redis.Client
var ctx = context.Background()

type CacheService struct {
    client *redis.Client
}

func NewCacheService(addr string) *CacheService {
    rdb := redis.NewClient(&redis.Options{
        Addr: addr,
    })

    return &CacheService{client: rdb}
}

func (c *CacheService) Set(key, value string, expiration time.Duration) error {
    return c.client.Set(ctx, key, value, expiration).Err()
}

func (c *CacheService) Get(key string) (string, error) {
    return c.client.Get(ctx, key).Result()
}

func main() {
    // Initialize Redis client
    cache := NewCacheService("redis:6379")

    r := gin.Default()

    r.GET("/", func(c *gin.Context) {
        c.JSON(http.StatusOK, gin.H{
            "message": "Hello World from Microservice with Redis!",
        })
    })

    r.GET("/cache/:key", func(c *gin.Context) {
        key := c.Param("key")
        value, err := cache.Get(key)
        if err != nil {
            c.JSON(http.StatusNotFound, gin.H{"error": "Key not found"})
            return
        }

        c.JSON(http.StatusOK, gin.H{
            "key":   key,
            "value": value,
        })
    })

    r.POST("/cache/:key", func(c *gin.Context) {
        key := c.Param("key")
        var request struct {
            Value string `json:"value"`
            TTL   int    `json:"ttl,omitempty"`
        }

        if err := c.ShouldBindJSON(&request); err != nil {
            c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
            return
        }

        ttl := time.Duration(request.TTL) * time.Second
        if request.TTL == 0 {
            ttl = time.Hour // Default 1 hour
        }

        if err := cache.Set(key, request.Value, ttl); err != nil {
            c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
            return
        }

        c.JSON(http.StatusOK, gin.H{
            "message": "Key set successfully",
            "key":     key,
            "value":   request.Value,
        })
    })

    r.GET("/health", func(c *gin.Context) {
        // Test Redis connection
        _, err := cache.client.Ping(ctx).Result()
        if err != nil {
            c.JSON(http.StatusServiceUnavailable, gin.H{
                "status": "DOWN",
                "redis":  "disconnected",
            })
            return
        }

        c.JSON(http.StatusOK, gin.H{
            "status": "UP",
            "redis":  "connected",
        })
    })

    r.Run(":8080")
}
```

### Dockerfile

```dockerfile
FROM golang:1.21-alpine AS build
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .

FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=build /app/main .
EXPOSE 8080
CMD ["./main"]
```

## Docker Compose Examples

### Gin + PostgreSQL + Redis

```yaml
version: "3.8"
services:
  app:
    build: ./gin-app
    ports:
      - "8080:8080"
    environment:
      - DATABASE_URL=postgres://user:password@postgres:5432/myapp?sslmode=disable
      - REDIS_URL=redis:6379
    depends_on:
      - postgres
      - redis

  postgres:
    image: postgres:15-alpine
    environment:
      POSTGRES_DB: myapp
      POSTGRES_USER: user
      POSTGRES_PASSWORD: password
    volumes:
      - postgres_data:/var/lib/postgresql/data

  redis:
    image: redis:alpine

volumes:
  postgres_data:
```

### Microservices Setup

```yaml
version: "3.8"
services:
  api-gateway:
    build: ./api-gateway
    ports:
      - "8080:8080"
    depends_on:
      - user-service
      - order-service

  user-service:
    build: ./user-service
    ports:
      - "8081:8080"
    depends_on:
      - postgres

  order-service:
    build: ./order-service
    ports:
      - "8082:8080"
    depends_on:
      - postgres

  postgres:
    image: postgres:15-alpine
    environment:
      POSTGRES_DB: microservices
      POSTGRES_USER: user
      POSTGRES_PASSWORD: password
```

### gRPC Services

```yaml
version: "3.8"
services:
  grpc-server:
    build: ./grpc-server
    ports:
      - "50051:50051"

  grpc-client:
    build: ./grpc-client
    depends_on:
      - grpc-server
    environment:
      - GRPC_SERVER=grpc-server:50051
```

## Production Optimizations

### Distroless Image

```dockerfile
FROM golang:1.21-alpine AS build
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -ldflags="-w -s" -o main .

FROM gcr.io/distroless/static-debian11
WORKDIR /
COPY --from=build /app/main .
EXPOSE 8080
USER nonroot:nonroot
CMD ["./main"]
```

### Scratch Image (Ultra minimal)

```dockerfile
FROM golang:1.21-alpine AS build
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -ldflags="-w -s" -o main .

FROM scratch
COPY --from=build /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=build /app/main .
EXPOSE 8080
CMD ["./main"]
```

### .dockerignore

```
.git
.gitignore
README.md
.env
.vscode/
.idea/
*.log
coverage.txt
vendor/
```

### Health Check

```dockerfile
FROM alpine:latest
RUN apk --no-cache add ca-certificates curl
WORKDIR /root/
COPY --from=build /app/main .
EXPOSE 8080
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:8080/health || exit 1
CMD ["./main"]
```

Tất cả các project Go trên đều có thể build và chạy với Docker. Mỗi project đại diện cho một pattern phổ biến trong Go development, từ web frameworks đến microservices và CLI tools.
