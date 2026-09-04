# --- Stage 1: Build the application using Maven ---
FROM maven:3.8.6-openjdk-8 AS build
WORKDIR /app

# Copy the dependency model file first to cache downloads
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copy the entire source directory code tree into the container stage
COPY src ./src

# Compile and package the WAR file
RUN mvn clean package -DskipTests

# --- Stage 2: Runtime Environment Engine ---
FROM openjdk:8-jre-slim
WORKDIR /app

# Copy the compiled war file from the build container stage
COPY --from=build /app/target/global-education-advisors-*.war app.war

# Expose the application network port
EXPOSE 8080

# Configure execution command to start the Spring Boot web application context
ENTRYPOINT ["java", "-jar", "app.war"]