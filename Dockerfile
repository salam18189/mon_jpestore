# Étape 1 : Build (Image officielle Maven avec JDK 17)
FROM maven:3.8.8-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Étape 2 : Runtime (Image officielle Tomcat compatible JDK 17)
FROM tomcat:9.0-jdk17-temurin-slim
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=build /app/target/jpetstore.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
