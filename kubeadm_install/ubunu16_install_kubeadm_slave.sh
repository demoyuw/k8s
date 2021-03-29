#!/bin/bash
# Ubuntu 16.04 LTS install k8s
# OS hostname need all lower case


############################################################################
# Check root privilege: Make sure only root can run our script
if [ $EUID -ne 0 ] ; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

LOGFILE=$HOME/ubuntu16installk8s_master.log
touch $LOGFILE

sed -i "s,tw.,,g" /etc/apt/sources.list >> $LOGFILE

cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
br_netfilter
EOF

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sudo sysctl --system >> $LOGFILE


# apt-get install & upgrade
echo "========================================================================================"  >> $LOGFILE 
echo "apt-get install & upgrade" >> $LOGFILE
sudo apt-get update >> $LOGFILE
sudo apt-get install -y apt-transport-https ca-certificates curl >> $LOGFILE
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg >> $LOGFILE
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update  >> $LOGFILE
sudo apt-get install -y kubelet kubeadm kubectl docker.io >> $LOGFILE
# mark kubelet, kubectl, kubeadm from apt server to avoid apt-get upgrade
sudo apt-mark hold kubelet kubeadm kubectl >> $LOGFILE

sudo apt-get update -y && sudo apt-get upgrade -y >> $LOGFILE

sudo swapoff -a >> $LOGFILE