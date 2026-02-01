# Étape 1 : Build (on utilise Maven pour compiler le projet)
FROM maven:3.8.6-openjdk-11-slim AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Étape 2 : Runtime (on ne garde que le serveur Tomcat et le fichier compilé)
FROM tomcat:9.0-jdk11-openjdk-slim
# On supprime les dossiers par défaut de Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*
# On copie le fichier .war généré à l'étape 1 vers le dossier Tomcat
COPY --from=build /app/target/jpetstore.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
