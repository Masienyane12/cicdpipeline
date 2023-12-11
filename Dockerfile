# Build Stage
FROM gradle:8.0.2-jdk17 AS build
WORKDIR /app
COPY build.gradle settings.gradle /app/
COPY src /app/src
RUN gradle build -x test

# Runtime Stage
FROM openjdk:17-jre-slim
COPY --from=build /app/build/libs/*.jar app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
