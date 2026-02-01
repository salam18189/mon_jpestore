# Étape 1 : Build (on utilise Maven pour compiler le projet)
FROM maven:3.8.7-eclispe-temurin-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Étape 2 : Runtime (on ne garde que le serveur Tomcat et le fichier compilé)
FROM tomcat:10.1-jdk17-temurin-slim
# On supprime les dossiers par défaut de Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*
# On copie le fichier .war généré à l'étape 1 vers le dossier Tomcat
COPY --from=build /app/target/jpetstore.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
