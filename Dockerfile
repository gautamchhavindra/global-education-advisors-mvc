# Stage 1: Build the application using Maven and Java 8
FROM maven:3.8.4-openjdk-8 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Stage 2: Run the application using the full OpenJDK 8 image
FROM openjdk:8
WORKDIR /app
COPY --from=build /app/target/*.war /app/app.war
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.war"]