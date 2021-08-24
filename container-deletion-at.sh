#This script contains the commands to delete a postgress and sonarqube containers
#Also delete volumes that correspond to the containes 

#Delete containers
docker rm -f sonardb sonarqube jenkins nexus
#Delete volumes
docker volume rm postgresql postgresql_data
docker volume rm sonarqube_data sonarqube_extensions sonarqube_logs
docker volume rm jenkins_home
docker volume rm nexus_data
#Delete network
docker network remove att-net