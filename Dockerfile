# First Stage: Build the application
FROM maven:3.9.6-eclipse-temurin-21 AS build

WORKDIR /app

# Copy pom.xml and src folder
COPY pom.xml .
COPY src ./src

# Package the application
RUN mvn clean package -DskipTests

# Second Stage: Run the application
FROM openjdk:21-jdk-slim

WORKDIR /app

# Copy the packaged jar from the builder stage
COPY --from=build /app/target/jobportal-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]