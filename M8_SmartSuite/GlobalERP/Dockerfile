

# =========================
# Stage 1: Build with JDK 17.
# =========================
FROM maven:3.9.6-eclipse-temurin-17 AS build

WORKDIR /app

# Copy pom.xml first for caching
COPY pom.xml .

# Download dependencies
RUN mvn dependency:go-offline

# Copy source
COPY src ./src
COPY WebContent ./WebContent

# Build WAR
RUN mvn clean package -DskipTests

# =========================
# Stage 2: Run with Tomcat + JDK 17
# =========================
FROM tomcat:9.0-jdk17-temurin

# Remove default applications
RUN rm -rf /usr/local/tomcat/webapps/*

# Deploy WAR as ROOT app
COPY --from=build /app/target/GlobalERP-0.0.1-SNAPSHOT.war /usr/local/tomcat/webapps/SmartSuite.war

# Expose Tomcat port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
