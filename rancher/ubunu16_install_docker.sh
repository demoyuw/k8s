#!/bin/bash

WORK_DIR=/home/demoyuw
LOGFILE=$WORK_DIR/log/rancher_install.log
mkdir $WORK_DIR/log
touch $LOGFILE

apt-get update &>> $LOGFILE
apt-get install     apt-transport-https     ca-certificates     curl     software-properties-common &>> $LOGFILE
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable" &>> $LOGFILE
apt-get update &>> $LOGFILE 
apt-get install docker-ce=17.03.2~ce-0~ubuntu-xenial -y &>> $LOGFILE