# Ryver Bank API

The Ryver Bank API is built as a collection of microservices.

## Services

### ryver-registry

Ryver Registry is the service registry for the entire system. It is built on top of [Netflix Eureka](https://github.com/Netflix/eureka), with the main purpose of **coordinating all other microservices**.

Ryver Registry runs on the standard Eureka port of `8761`. To view a dashboard of all running services, visit the [dashboard](http://localhost:8761/) in your browser.

Without the Ryver Registry service, all other services will not be able to coordinate with each other.

#### Registering a client

To be detectable, a client must register with Eureka and provide metadata about itself -- such as host, port, and other details. Eureka receives heartbeat messages from each instance of the client, and keeps track of all instances of the client.

To register a client, simply have the `spring-cloud-starter-netflix-eureka-client` dependency on the classpath.

```xml
  <dependencies>
    <dependency>
      <groupId>org.springframework.cloud</groupId>
      <artifactId>spring-cloud-starter-netflix-eureka-client</artifactId>
    </dependency>
    <!-- other dependencies -->
  </dependencies>
```

Define the port number of the client service in `src/main/resources/application.yml`.

```yml
server:
  port: <your-client-service-port>
```

Finally, define the name of the client service and the location of the Eureka Server in `src/main/resources/bootstrap.yml`.

```yml
spring:
  application:
    name: <your-client-service-name>
eureka:
  client:
    service-url:
      default-zone: ${EUREKA_URL:http://localhost:8761}/eureka
  instance:
    prefer-ip-address: true
```

> Use `bootstrap.yml` for any configuration that is required before `application.yml` is loaded.

Eureka will automatically configure the Spring Boot application to register itself with the defined Eureka Server.

#### Using the registry

To use the registry to find other services to talk to, first activate the `DiscoveryClient` with the `@EnableDiscoveryClient` annotation on the Spring Boot application.

```java
import org.springframework.cloud.client.discovery.DiscoveryClient;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;

@SpringBootApplication
@EnableDiscoveryClient
public class YourClientApplication {
    @Autowired
    private DiscoveryClient discoveryClient;

    public static void main(String[] args) {
        List<ServiceInstance> instances = discoveryClient.getInstances("<service-name>");
        // Get the URI of the first instance of "<service-name>".
        URI uri = instances.get(0).getUri();
        ...
    }
}
```

The discovery client lets you find all instances of a client service, given its service name as defined by its `spring.application.name` property in its `src/main/resources/bootstrap.yml`.

The `ServiceInstance` interface exposes `getUri()`, `getHost()`, and `getPort()` methods amongst other things. You can then use these to perform the necessary REST interactions with the right service.
