#!/bin/bash

SONARQ_USER="sonarqube"
SONARQ_USER_PASS="Pragm@11"
SONARQ_USER_PATH="/home/$SONARQ_USER"
BINARY_PATH="https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-9.4.0.54424.zip"
ZIP_FILE_NAME="sonarqube_install.zip"
UNZIPPED_FILE_NAME="sonarqube_install"

echo -e "\n---------------------------------------------"
echo -e "Installing dependencies"
echo -e "---------------------------------------------\n"
sudo apt update     -y
sudo apt install    -y openjdk-11-jre-headless
sudo apt install    -y unzip
sudo apt install    -y net-tools

cd /

echo -e "\n---------------------------------------------"
echo -e "Add user"
echo -e "---------------------------------------------\n"
sudo useradd -m -s /bin/bash "$SONARQ_USER"
echo "$SONARQ_USER:Pragm@11" | sudo chpasswd

echo -e "\n---------------------------------------------"
echo -e "Change permissions"
echo -e "---------------------------------------------\n"
sudo usermod -aG sudo "$SONARQ_USER"
sudo chown -R "$SONARQ_USER:$SONARQ_USER" "$SONARQ_USER_PATH"
sudo chmod 711 "$SONARQ_USER_PATH"

echo -e "\n---------------------------------------------"
echo -e "Move location"
echo -e "---------------------------------------------\n"
cd $SONARQ_USER_PATH
echo $SONARQ_USER_PASS | sudo -S -u $SONARQ_USER bash <<EOF

echo -e "\n---------------------------------------------"
echo -e "Get installer"
echo -e "---------------------------------------------\n"
wget $BINARY_PATH -O ./$ZIP_FILE_NAME
unzip ./$ZIP_FILE_NAME -d ./$UNZIPPED_FILE_NAME

echo -e "\n---------------------------------------------"
echo -e "Executing SonarQube"
echo -e "---------------------------------------------\n"
./$UNZIPPED_FILE_NAME/sonarqube*/bin/linux*/sonar.sh console
EOF
