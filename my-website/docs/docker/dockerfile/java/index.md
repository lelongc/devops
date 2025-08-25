# Java Projects with Docker

Tổng hợp các loại project Java phổ biến với Dockerfile tương ứng.

## 1. Basic Java Application

### HelloWorld.java

```java
public class HelloWorld {
    public static void main(String[] args) {
        System.out.println("Hello World from Java!");
        System.out.println("Basic Java application is running...");
    }
}
```

### Dockerfile

```dockerfile
FROM openjdk:17-jdk-slim
WORKDIR /app
COPY *.java .
RUN javac HelloWorld.java
CMD ["java", "HelloWorld"]
```

## 2. Spring Boot REST API

### pom.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0">
    <modelVersion>4.0.0</modelVersion>
    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>3.2.0</version>
        <relativePath/>
    </parent>

    <groupId>com.example</groupId>
    <artifactId>hello-world</artifactId>
    <version>0.0.1-SNAPSHOT</version>
    <packaging>jar</packaging>

    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-actuator</artifactId>
        </dependency>
    </dependencies>
</project>
```

### src/main/java/com/example/Application.java

```java
package com.example;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class Application {
    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }
}
```

### src/main/java/com/example/HelloController.java

```java
package com.example;

import org.springframework.web.bind.annotation.*;
import java.util.Map;
import java.util.HashMap;

@RestController
public class HelloController {

    @GetMapping("/")
    public Map<String, String> hello() {
        Map<String, String> response = new HashMap<>();
        response.put("message", "Hello World from Spring Boot!");
        return response;
    }

    @GetMapping("/api/health")
    public Map<String, String> health() {
        Map<String, String> response = new HashMap<>();
        response.put("status", "UP");
        response.put("framework", "Spring Boot");
        return response;
    }

    @PostMapping("/api/echo")
    public Map<String, String> echo(@RequestBody Map<String, String> request) {
        Map<String, String> response = new HashMap<>();
        response.put("echo", "You said: " + request.get("message"));
        return response;
    }
}
```

### Dockerfile

```dockerfile
FROM maven:3.9-openjdk-17 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline -B
COPY src ./src
RUN mvn clean package -DskipTests

FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
```

## 3. Spring Boot with JPA and MySQL

### pom.xml (additional dependencies)

```xml
<dependencies>
    <!-- ...existing dependencies... -->
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-data-jpa</artifactId>
    </dependency>
    <dependency>
        <groupId>mysql</groupId>
        <artifactId>mysql-connector-java</artifactId>
        <scope>runtime</scope>
    </dependency>
</dependencies>
```

### src/main/java/com/example/User.java

```java
package com.example;

import jakarta.persistence.*;

@Entity
@Table(name = "users")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String name;

    @Column(nullable = false, unique = true)
    private String email;

    // Constructors
    public User() {}

    public User(String name, String email) {
        this.name = name;
        this.email = email;
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
}
```

### src/main/java/com/example/UserRepository.java

```java
package com.example;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    User findByEmail(String email);
}
```

### src/main/java/com/example/UserController.java

```java
package com.example;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/users")
public class UserController {

    @Autowired
    private UserRepository userRepository;

    @GetMapping
    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    @PostMapping
    public User createUser(@RequestBody User user) {
        return userRepository.save(user);
    }

    @GetMapping("/{id}")
    public User getUserById(@PathVariable Long id) {
        return userRepository.findById(id).orElse(null);
    }
}
```

### src/main/resources/application.properties

```properties
spring.datasource.url=jdbc:mysql://mysql:3306/myapp
spring.datasource.username=root
spring.datasource.password=password
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver

spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true
spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.MySQL8Dialect

server.port=8080
```

### Dockerfile

```dockerfile
FROM maven:3.9-openjdk-17 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline -B
COPY src ./src
RUN mvn clean package -DskipTests

FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
```

## 4. Quarkus Native Application

### pom.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0">
    <modelVersion>4.0.0</modelVersion>

    <groupId>com.example</groupId>
    <artifactId>quarkus-hello</artifactId>
    <version>1.0.0</version>

    <properties>
        <quarkus.version>3.6.0</quarkus.version>
        <maven.compiler.source>17</maven.compiler.source>
        <maven.compiler.target>17</maven.compiler.target>
    </properties>

    <dependencyManagement>
        <dependencies>
            <dependency>
                <groupId>io.quarkus</groupId>
                <artifactId>quarkus-bom</artifactId>
                <version>${quarkus.version}</version>
                <type>pom</type>
                <scope>import</scope>
            </dependency>
        </dependencies>
    </dependencyManagement>

    <dependencies>
        <dependency>
            <groupId>io.quarkus</groupId>
            <artifactId>quarkus-resteasy-reactive-jackson</artifactId>
        </dependency>
    </dependencies>

    <build>
        <plugins>
            <plugin>
                <groupId>io.quarkus</groupId>
                <artifactId>quarkus-maven-plugin</artifactId>
                <version>${quarkus.version}</version>
            </plugin>
        </plugins>
    </build>
</project>
```

### src/main/java/com/example/HelloResource.java

```java
package com.example;

import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;
import java.util.Map;

@Path("/")
public class HelloResource {

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Map<String, String> hello() {
        return Map.of("message", "Hello World from Quarkus!");
    }

    @GET
    @Path("/health")
    @Produces(MediaType.APPLICATION_JSON)
    public Map<String, String> health() {
        return Map.of(
            "status", "UP",
            "framework", "Quarkus"
        );
    }
}
```

### Dockerfile (JVM mode)

```dockerfile
FROM maven:3.9-openjdk-17 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline -B
COPY src ./src
RUN mvn clean package -Dquarkus.package.type=uber-jar

FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=build /app/target/*-runner.jar app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
```

### Dockerfile.native (Native mode)

```dockerfile
FROM quay.io/quarkus/ubi-quarkus-graalvmce-builder-image:22.3-java17 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline -B
COPY src ./src
RUN mvn clean package -Pnative -DskipTests

FROM quay.io/quarkus/quarkus-micro-image:2.0
WORKDIR /app
COPY --from=build /app/target/*-runner /application
EXPOSE 8080
CMD ["./application", "-Dquarkus.http.host=0.0.0.0"]
```

## 5. Micronaut Application

### build.gradle

```gradle
plugins {
    id 'application'
    id 'io.micronaut.application' version '4.2.1'
}

version = '0.1'
group = 'com.example'

repositories {
    mavenCentral()
}

dependencies {
    implementation 'io.micronaut:micronaut-http-server-netty'
    implementation 'io.micronaut:micronaut-jackson-databind'
    implementation 'io.micronaut.validation:micronaut-validation'
    runtimeOnly 'ch.qos.logback:logback-classic'
}

application {
    mainClass.set('com.example.Application')
}

micronaut {
    runtime 'netty'
    testRuntime 'junit5'
    processing {
        incremental true
        annotations 'com.example.*'
    }
}
```

### src/main/java/com/example/Application.java

```java
package com.example;

import io.micronaut.runtime.Micronaut;

public class Application {
    public static void main(String[] args) {
        Micronaut.run(Application.class, args);
    }
}
```

### src/main/java/com/example/HelloController.java

```java
package com.example;

import io.micronaut.http.annotation.*;
import java.util.Map;

@Controller
public class HelloController {

    @Get("/")
    public Map<String, String> hello() {
        return Map.of("message", "Hello World from Micronaut!");
    }

    @Get("/health")
    public Map<String, String> health() {
        return Map.of(
            "status", "UP",
            "framework", "Micronaut"
        );
    }

    @Post("/echo")
    public Map<String, String> echo(@Body Map<String, String> request) {
        return Map.of("echo", "You said: " + request.get("message"));
    }
}
```

### Dockerfile

```dockerfile
FROM gradle:8.5-jdk17 AS build
WORKDIR /app
COPY build.gradle settings.gradle ./
RUN gradle dependencies --no-daemon
COPY src ./src
RUN gradle build --no-daemon

FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=build /app/build/libs/*-all.jar app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
```

## 6. Maven Multi-Module Project

### pom.xml (parent)

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0">
    <modelVersion>4.0.0</modelVersion>

    <groupId>com.example</groupId>
    <artifactId>multi-module-app</artifactId>
    <version>1.0.0</version>
    <packaging>pom</packaging>

    <modules>
        <module>common</module>
        <module>web</module>
        <module>service</module>
    </modules>

    <properties>
        <maven.compiler.source>17</maven.compiler.source>
        <maven.compiler.target>17</maven.compiler.target>
        <spring.boot.version>3.2.0</spring.boot.version>
    </properties>

    <dependencyManagement>
        <dependencies>
            <dependency>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-dependencies</artifactId>
                <version>${spring.boot.version}</version>
                <type>pom</type>
                <scope>import</scope>
            </dependency>
        </dependencies>
    </dependencyManagement>
</project>
```

### web/src/main/java/com/example/web/WebApplication.java

```java
package com.example.web;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import java.util.Map;

@SpringBootApplication
@RestController
public class WebApplication {

    public static void main(String[] args) {
        SpringApplication.run(WebApplication.class, args);
    }

    @GetMapping("/")
    public Map<String, String> hello() {
        return Map.of("message", "Hello World from Multi-Module Spring Boot!");
    }
}
```

### Dockerfile

```dockerfile
FROM maven:3.9-openjdk-17 AS build
WORKDIR /app
COPY pom.xml .
COPY common/pom.xml ./common/
COPY web/pom.xml ./web/
COPY service/pom.xml ./service/
RUN mvn dependency:go-offline -B

COPY common/src ./common/src
COPY web/src ./web/src
COPY service/src ./service/src
RUN mvn clean package -DskipTests

FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=build /app/web/target/*.jar app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
```

## 7. Play Framework (Scala)

### build.sbt

```scala
name := "play-hello-world"
version := "1.0"
scalaVersion := "2.13.12"

lazy val root = (project in file(".")).enablePlugins(PlayJava)

libraryDependencies ++= Seq(
  guice,
  "com.typesafe.play" %% "play-json" % "2.9.4"
)
```

### app/controllers/HomeController.java

```java
package controllers;

import play.mvc.*;
import play.libs.Json;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.node.ObjectNode;

public class HomeController extends Controller {

    public Result index() {
        ObjectNode result = Json.newObject();
        result.put("message", "Hello World from Play Framework!");
        return ok(result);
    }

    public Result health() {
        ObjectNode result = Json.newObject();
        result.put("status", "UP");
        result.put("framework", "Play Framework");
        return ok(result);
    }
}
```

### conf/routes

```
GET     /                           controllers.HomeController.index()
GET     /health                     controllers.HomeController.health()
```

### Dockerfile

```dockerfile
FROM sbtscala/scala-sbt:openjdk-17.0.2_1.7.1_2.13.8 AS build
WORKDIR /app
COPY build.sbt .
COPY project ./project
RUN sbt update
COPY . .
RUN sbt dist

FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=build /app/target/universal/*.zip app.zip
RUN unzip app.zip && rm app.zip
RUN mv play-hello-world-* play-app
EXPOSE 9000
CMD ["./play-app/bin/play-hello-world"]
```

## 8. Vert.x Application

### pom.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0">
    <modelVersion>4.0.0</modelVersion>

    <groupId>com.example</groupId>
    <artifactId>vertx-hello</artifactId>
    <version>1.0.0</version>

    <properties>
        <maven.compiler.source>17</maven.compiler.source>
        <maven.compiler.target>17</maven.compiler.target>
        <vertx.version>4.5.0</vertx.version>
    </properties>

    <dependencies>
        <dependency>
            <groupId>io.vertx</groupId>
            <artifactId>vertx-core</artifactId>
            <version>${vertx.version}</version>
        </dependency>
        <dependency>
            <groupId>io.vertx</groupId>
            <artifactId>vertx-web</artifactId>
            <version>${vertx.version}</version>
        </dependency>
    </dependencies>

    <build>
        <plugins>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-shade-plugin</artifactId>
                <version>3.4.1</version>
                <executions>
                    <execution>
                        <phase>package</phase>
                        <goals>
                            <goal>shade</goal>
                        </goals>
                        <configuration>
                            <transformers>
                                <transformer implementation="org.apache.maven.plugins.shade.resource.ManifestResourceTransformer">
                                    <mainClass>io.vertx.core.Launcher</mainClass>
                                </transformer>
                            </transformers>
                            <outputFile>${project.build.directory}/${project.artifactId}-fat.jar</outputFile>
                        </configuration>
                    </execution>
                </executions>
            </plugin>
        </plugins>
    </build>
</project>
```

### src/main/java/com/example/MainVerticle.java

```java
package com.example;

import io.vertx.core.AbstractVerticle;
import io.vertx.core.Promise;
import io.vertx.core.json.JsonObject;
import io.vertx.ext.web.Router;
import io.vertx.ext.web.RoutingContext;

public class MainVerticle extends AbstractVerticle {

    @Override
    public void start(Promise<Void> startPromise) {
        Router router = Router.router(vertx);

        router.get("/").handler(this::handleHello);
        router.get("/health").handler(this::handleHealth);

        vertx.createHttpServer()
            .requestHandler(router)
            .listen(8080, http -> {
                if (http.succeeded()) {
                    startPromise.complete();
                    System.out.println("HTTP server started on port 8080");
                } else {
                    startPromise.fail(http.cause());
                }
            });
    }

    private void handleHello(RoutingContext context) {
        JsonObject response = new JsonObject()
            .put("message", "Hello World from Vert.x!");

        context.response()
            .putHeader("content-type", "application/json")
            .end(response.encode());
    }

    private void handleHealth(RoutingContext context) {
        JsonObject response = new JsonObject()
            .put("status", "UP")
            .put("framework", "Vert.x");

        context.response()
            .putHeader("content-type", "application/json")
            .end(response.encode());
    }
}
```

### Dockerfile

```dockerfile
FROM maven:3.9-openjdk-17 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline -B
COPY src ./src
RUN mvn clean package

FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=build /app/target/*-fat.jar app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar", "run", "com.example.MainVerticle"]
```

## 9. Kafka Consumer/Producer

### pom.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0">
    <modelVersion>4.0.0</modelVersion>

    <groupId>com.example</groupId>
    <artifactId>kafka-app</artifactId>
    <version>1.0.0</version>

    <properties>
        <maven.compiler.source>17</maven.compiler.source>
        <maven.compiler.target>17</maven.compiler.target>
    </properties>

    <dependencies>
        <dependency>
            <groupId>org.apache.kafka</groupId>
            <artifactId>kafka-clients</artifactId>
            <version>3.6.0</version>
        </dependency>
        <dependency>
            <groupId>org.slf4j</groupId>
            <artifactId>slf4j-simple</artifactId>
            <version>2.0.9</version>
        </dependency>
    </dependencies>
</project>
```

### src/main/java/com/example/KafkaApplication.java

```java
package com.example;

import org.apache.kafka.clients.consumer.*;
import org.apache.kafka.clients.producer.*;
import org.apache.kafka.common.serialization.StringDeserializer;
import org.apache.kafka.common.serialization.StringSerializer;

import java.time.Duration;
import java.util.Collections;
import java.util.Properties;
import java.util.concurrent.CompletableFuture;

public class KafkaApplication {

    public static void main(String[] args) {
        System.out.println("Hello World from Kafka Application!");

        // Start producer and consumer
        CompletableFuture.runAsync(KafkaApplication::runProducer);
        CompletableFuture.runAsync(KafkaApplication::runConsumer);

        // Keep the application running
        try {
            Thread.sleep(Long.MAX_VALUE);
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        }
    }

    private static void runProducer() {
        Properties props = new Properties();
        props.put(ProducerConfig.BOOTSTRAP_SERVERS_CONFIG, "kafka:9092");
        props.put(ProducerConfig.KEY_SERIALIZER_CLASS_CONFIG, StringSerializer.class.getName());
        props.put(ProducerConfig.VALUE_SERIALIZER_CLASS_CONFIG, StringSerializer.class.getName());

        try (Producer<String, String> producer = new KafkaProducer<>(props)) {
            int counter = 0;
            while (true) {
                String message = "Hello World message #" + counter++;
                ProducerRecord<String, String> record = new ProducerRecord<>("hello-topic", message);

                producer.send(record, (metadata, exception) -> {
                    if (exception == null) {
                        System.out.println("Sent: " + message);
                    } else {
                        System.err.println("Error sending message: " + exception.getMessage());
                    }
                });

                Thread.sleep(5000);
            }
        } catch (Exception e) {
            System.err.println("Producer error: " + e.getMessage());
        }
    }

    private static void runConsumer() {
        Properties props = new Properties();
        props.put(ConsumerConfig.BOOTSTRAP_SERVERS_CONFIG, "kafka:9092");
        props.put(ConsumerConfig.GROUP_ID_CONFIG, "hello-group");
        props.put(ConsumerConfig.KEY_DESERIALIZER_CLASS_CONFIG, StringDeserializer.class.getName());
        props.put(ConsumerConfig.VALUE_DESERIALIZER_CLASS_CONFIG, StringDeserializer.class.getName());
        props.put(ConsumerConfig.AUTO_OFFSET_RESET_CONFIG, "earliest");

        try (Consumer<String, String> consumer = new KafkaConsumer<>(props)) {
            consumer.subscribe(Collections.singletonList("hello-topic"));

            while (true) {
                ConsumerRecords<String, String> records = consumer.poll(Duration.ofMillis(1000));
                for (ConsumerRecord<String, String> record : records) {
                    System.out.println("Received: " + record.value());
                }
            }
        } catch (Exception e) {
            System.err.println("Consumer error: " + e.getMessage());
        }
    }
}
```

### Dockerfile

```dockerfile
FROM maven:3.9-openjdk-17 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline -B
COPY src ./src
RUN mvn clean package

FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
CMD ["java", "-jar", "app.jar"]
```

## 10. Gradle-based Spring Boot

### build.gradle

```gradle
plugins {
    id 'org.springframework.boot' version '3.2.0'
    id 'io.spring.dependency-management' version '1.1.4'
    id 'java'
}

group = 'com.example'
version = '0.0.1-SNAPSHOT'
sourceCompatibility = '17'

repositories {
    mavenCentral()
}

dependencies {
    implementation 'org.springframework.boot:spring-boot-starter-web'
    implementation 'org.springframework.boot:spring-boot-starter-actuator'
    testImplementation 'org.springframework.boot:spring-boot-starter-test'
}

tasks.named('test') {
    useJUnitPlatform()
}
```

### src/main/java/com/example/GradleApplication.java

```java
package com.example;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import java.util.Map;

@SpringBootApplication
@RestController
public class GradleApplication {

    public static void main(String[] args) {
        SpringApplication.run(GradleApplication.class, args);
    }

    @GetMapping("/")
    public Map<String, String> hello() {
        return Map.of("message", "Hello World from Gradle + Spring Boot!");
    }
}
```

### Dockerfile

```dockerfile
FROM gradle:8.5-jdk17 AS build
WORKDIR /app
COPY build.gradle settings.gradle ./
RUN gradle dependencies --no-daemon
COPY src ./src
RUN gradle build --no-daemon

FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=build /app/build/libs/*.jar app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
```

## Docker Compose Examples

### Spring Boot + MySQL + Redis

```yaml
version: "3.8"
services:
  app:
    build: ./spring-app
    ports:
      - "8080:8080"
    environment:
      - SPRING_DATASOURCE_URL=jdbc:mysql://mysql:3306/myapp
      - SPRING_REDIS_HOST=redis
    depends_on:
      - mysql
      - redis

  mysql:
    image: mysql:8.0
    environment:
      MYSQL_ROOT_PASSWORD: password
      MYSQL_DATABASE: myapp
    volumes:
      - mysql_data:/var/lib/mysql

  redis:
    image: redis:alpine

volumes:
  mysql_data:
```

### Microservices with Kafka

```yaml
version: "3.8"
services:
  zookeeper:
    image: confluentinc/cp-zookeeper:latest
    environment:
      ZOOKEEPER_CLIENT_PORT: 2181

  kafka:
    image: confluentinc/cp-kafka:latest
    depends_on:
      - zookeeper
    environment:
      KAFKA_BROKER_ID: 1
      KAFKA_ZOOKEEPER_CONNECT: zookeeper:2181
      KAFKA_ADVERTISED_LISTENERS: PLAINTEXT://kafka:9092
      KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR: 1

  producer-service:
    build: ./kafka-producer
    depends_on:
      - kafka

  consumer-service:
    build: ./kafka-consumer
    depends_on:
      - kafka
```

### Multi-Module Application

```yaml
version: "3.8"
services:
  web-service:
    build:
      context: .
      dockerfile: Dockerfile.web
    ports:
      - "8080:8080"
    depends_on:
      - api-service

  api-service:
    build:
      context: .
      dockerfile: Dockerfile.api
    ports:
      - "8081:8081"
    depends_on:
      - database

  database:
    image: postgres:15
    environment:
      POSTGRES_DB: myapp
      POSTGRES_USER: user
      POSTGRES_PASSWORD: password
```

## Production Optimizations

### Multi-stage with JRE

```dockerfile
FROM maven:3.9-openjdk-17 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline -B
COPY src ./src
RUN mvn clean package -DskipTests

FROM openjdk:17-jre-slim
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
RUN addgroup --system spring && adduser --system spring --ingroup spring
USER spring:spring
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
```

### Distroless Image

```dockerfile
FROM maven:3.9-openjdk-17 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline -B
COPY src ./src
RUN mvn clean package -DskipTests

FROM gcr.io/distroless/java17-debian11
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
CMD ["app.jar"]
```

### .dockerignore

```
target/
.mvn/
mvnw
mvnw.cmd
.git/
.gitignore
README.md
.idea/
*.iml
.vscode/
.classpath
.project
.settings/
```

### Health Check

```dockerfile
FROM openjdk:17-jre-slim
WORKDIR /app
COPY target/*.jar app.jar
EXPOSE 8080
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:8080/actuator/health || exit 1
CMD ["java", "-jar", "app.jar"]
```

Tất cả các project Java trên đều có thể build và chạy với Docker. Mỗi project đại diện cho một pattern phổ biến trong Java development, từ web frameworks đến microservices và message processing.
