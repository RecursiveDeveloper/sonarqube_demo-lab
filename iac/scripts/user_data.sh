#!/bin/bash

SONARQ_USER="sonarqube"
SONARQ_USER_PASS="Pragm@11"
SONARQ_USER_PATH="/home/${SONARQ_USER}"
BINARY_PATH="https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-9.9.8.100196.zip"
FILE_NAME="sonarqube_install"

echo -e "\n----------Installing dependencies----------\n"
apt update  -y
apt install -y openjdk-17-jre-headless
apt install -y unzip
apt install -y net-tools

echo -e "\n----------Manage user----------\n"
useradd -m -s /bin/bash "${SONARQ_USER}"
echo "${SONARQ_USER}:${SONARQ_USER_PASS}" | chpasswd
usermod -aG sudo "${SONARQ_USER}"
chown -R "${SONARQ_USER}:${SONARQ_USER}" "${SONARQ_USER_PATH}"
chmod 711 "${SONARQ_USER_PATH}"

echo -e "\n----------Install and execute Sonarqube----------\n"
cd ${SONARQ_USER_PATH}
echo ${SONARQ_USER_PASS} | su -s /bin/bash ${SONARQ_USER} <<EOF
wget ${BINARY_PATH} -O ./${FILE_NAME}.zip
unzip ./${FILE_NAME}.zip -d ./${FILE_NAME}
./${FILE_NAME}/sonarqube*/bin/linux*/sonar.sh start
EOF
