#!/bin/bash

LOGFILE=$HOME/ubuntu16_install_kubespray.log
touch $LOGFILE

git clone https://github.com/kubernetes-sigs/kubespray.git
chmod 755 -R kubespray

sudo apt-get update -y && sudo apt-get upgrade -y
# python
sudo apt-get install libssl-dev python3-pip -y

cd kubespray

# ansible
sudo pip3 install -r requirements.txt

# copy sample
cp -rfp inventory/sample inventory/mycluster

# Set node ip
declare -a IPS=(10.50.0.84 10.50.0.85)
CONFIG_FILE=inventory/mycluster/hosts.yaml python3 contrib/inventory_builder/inventory.py ${IPS[@]}

# edit and check setting
cat inventory/mycluster/group_vars/all/all.yml
cat inventory/mycluster/group_vars/k8s-cluster/k8s-cluster.yml

# ansible deploy
ansible-playbook -i inventory/mycluster/hosts.yaml  --become --become-user=root cluster.yml

# get admin config
mkdir -p $HOME/.kube
sudo cp /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# verify k8s service
kubectl get all --all-namespaces