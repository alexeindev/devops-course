#This script contains the commands to create a postgress and sonarqube containers
#for persisting data this script also creates volumes for the containers
#
#Create volumes
docker volume create postgresql
docker volume create postgresql_data
docker volume create sonarqube_logs
docker volume create sonarqube_data
docker volume create sonarqube_extensions
docker volume create jenkins_home
docker volume create nexus_data
#
#Create attached network
docker network create att-net

#
#Mount 
docker run -d --name sonardb --network att-net --restart always -e POSTGRES_USER=sonar -e POSTGRES_PASSWORD=sonar -v postgresql:/var/lib/postgresql -v postgresql_data:/var/lib/postgresql/data postgres:12.1-alpine
#
docker run -d --name sonarqube --network att-net -p 9000:9000 -e SONARQUBE_JDBC_URL=jdbc:postgresql://sonardb:5432/sonar -e SONAR_JDBC_USERNAME=sonar -e SONAR_JDBC_PASSWORD=sonar -v sonarqube_data:/opt/sonarqube/data -v sonarqube_extensions:/opt/sonarqube/extensions -v sonarqube_logs:/opt/sonarqube/logs sonarqube:8.9.0-community
#
docker run -d --name jenkins --network att-net -v jenkins_home:/var/jenkins_home -p 8080:8080 -p 50000:50000 jenkins/jenkins
#
docker run -d --name nexus --network att-net -v nexus_data:/nexus-data -p 8081:8081 sonatype/nexus3