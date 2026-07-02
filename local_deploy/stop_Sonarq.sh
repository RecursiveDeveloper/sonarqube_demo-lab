#!/bin/bash

IMAGE_NAME=sonarqube
CONTAINER_NAME=sonarqube
H2DB_VOLUME=sonar_H2db
LOGS_VOLUME=sonar_logs
EXT_VOLUME=sonar_ext

docker rm -f $CONTAINER_NAME
docker rmi $(docker image ls -a | grep -w "${IMAGE_NAME}" | docker images -q)
docker volume rm $(docker volume ls -q | grep -w "${H2DB_VOLUME}\|${LOGS_VOLUME}\|${EXT_VOLUME}")
