#!/bin/bash
# Ubuntu 16.04.2 LTS install k8s
# OS hostname need all lower case


############################################################################
# Check root privilege: Make sure only root can run our script
if [ $EUID -ne 0 ] ; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

LOGFILE=$HOME/ubuntu16installk8s_slave.log
touch $LOGFILE

sed -i "s,tw.,,g" /etc/apt/sources.list >> $LOGFILE

# apt-get install & upgrade
echo "========================================================================================"  >> $LOGFILE 
echo "apt-get install & upgrade" >> $LOGFILE
apt-get update >> $LOGFILE
apt-get install -y apt-transport-https >> $LOGFILE
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - >> $LOGFILE
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list  
deb http://apt.kubernetes.io/ kubernetes-xenial main 
EOF
apt-get update  >> $LOGFILE
apt-get install -y kubelet kubeadm docker.io  >> $LOGFILE
apt-get update -y  >> $LOGFILE
apt-get upgrade -y  >> $LOGFILE

# Create /etc/cni/net.d/10-weave.conf setting 
echo "========================================================================================"  >> $LOGFILE 
echo "add /etc/cni/net.d/10-weave.conf" >> $LOGFILE
mkdir /etc/cni  >> $LOGFILE 
mkdir /etc/cni/net.d  >> $LOGFILE 
cat <<EOF >/etc/cni/net.d/10-weave.conf  
{
    "name": "weave",
    "type": "weave-net"
}
EOF

# disable SWAP
sudo swapoff -a