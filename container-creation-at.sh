#This script contains the commands to create a postgress and sonarqube containers
#for persisting data this script also creates volumes for the containers
#
#Create volumes
docker volume create postgresql
docker volume create postgresql_data
#
docker volume create sonarqube_logs
docker volume create sonarqube_data
docker volume create sonarqube_extensions
#
#Create attached network
docker network create att-net
#
#Sonarqube config
sudo sysctl -w vm.max_map_count=524288
sudo sysctl -w fs.file-max=131072
ulimit -n 131072
ulimit -u 8192
#
#Mount 
docker run -d --name sonardb --network att-net --restart always -e POSTGRES_USER=sonar -e POSTGRES_PASSWORD=sonar -v postgresql:/var/lib/postgresql -v postgresql_data:/var/lib/postgresql/data postgres:12.1-alpine
#
docker run -d --name sonarqube --network att-net -p 9000:9000 -e SONARQUBE_JDBC_URL=jdbc:postgresql://sonardb:5432/sonar -e SONAR_JDBC_USERNAME=sonar -e SONAR_JDBC_PASSWORD=sonar -v sonarqube_data:/opt/sonarqube/data -v sonarqube_extensions:/opt/sonarqube/extensions -v sonarqube_logs:/opt/sonarqube/logs sonarqube:8.9.0-community

