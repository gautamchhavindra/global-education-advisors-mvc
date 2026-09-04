# Stage 1: Build the application using Maven and Java 8
FROM maven:3.8.4-openjdk-8 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Stage 2: Run the application using a full Eclipse Temurin Java 8 environment
FROM eclipse-temurin:8-jdk
WORKDIR /app
COPY --from=build /app/target/*.war /app/app.war
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.war"]