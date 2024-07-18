# Use a base image with Java 17 and Maven installed
FROM maven:3.8.4-openjdk-17-slim AS builder

# Install Git, apt-utils, and other dependencies
RUN apt-get update && apt-get install -y git apt-utils

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . .

# Build the application
RUN ./mvnw clean package -DskipTests

# Use a lightweight base image for running the application
FROM openjdk:17-jdk-slim

# Set the working directory in the container
WORKDIR /app

# Copy the built application from the builder stage
COPY --from=builder /app/target/elastic-beanstalk-deployment-0.0.1-SNAPSHOT.jar /app/elastic-beanstalk-deployment-0.0.1-SNAPSHOT.jar

# Expose the port the app runs on
EXPOSE 8080

# Run the application
CMD ["java", "-jar", "/app/elastic-beanstalk-deployment-0.0.1-SNAPSHOT.jar"]