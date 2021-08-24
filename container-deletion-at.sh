#This script contains the commands to create a postgress and sonarqube containers
#for persisting data this script also creates volumes for the containers
#Delete network
docker network remove att-net
#Delete containers
docker rm -f sonardb sonarqube
#Delete volumes
docker volume rm postgresql postgresql_data
docker volume rm sonarqube_data sonarqube_extensions sonarqube_logs