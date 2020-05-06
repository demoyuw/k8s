# 深入淺出Container, Kubernetes與GKE

課程所提供VM規格為 GCP Ubunt16.04LTS VM，規格為 n1-standard-1 (1 個 vCPU，3.75 GB 記憶體) 10G disk，防火牆支援HTTP and HTTPS，還在VPC的防火牆規則開了3個port for kubernetes。

Etcd port, tcp:2379  
Kubelet port, tcp:10250  
Kubernetes secure port, tcp:6443  

Windows 用戶製作自己的ssh key 並上傳到GCP可參考：https://www.techcoke.com/2017/01/google-compute-engine-putty-ssh-instances.html

課程實作上有相關問題，也可以到Issues上發單詢問。
