#!/bin/bash
# Ubuntu 16.04.2 LTS install k8s
# OS hostname need all lower case


apt-get update && apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list  
deb http://apt.kubernetes.io/ kubernetes-xenial main 
EOF
apt-get update
apt-get install -y kubelet kubeadm docker.io
apt-get update && apt-get upgrade -y

# Create /etc/cni/net.d/10-weave.conf setting 
mkdir /etc/cni
mkdir /etc/cni/net.d
cat <<EOF >/etc/cni/net.d/10-weave.conf  
{
    "name": "weave",
    "type": "weave-net"
}
EOF
