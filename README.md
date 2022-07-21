# 微服務Kubernetes與Docker開發實務班

課程所提供VM規格為 GCP Ubunt20.04LTS VM，規格為 n1-standard-1 (2 個 vCPU，4 GB 記憶體) 20G disk，防火牆支援HTTP and HTTPS，還在VPC的防火牆規則開了3個port for kubernetes。

Etcd port, tcp:2379  
Kubelet port, tcp:10250  
Kubernetes secure port, tcp:6443  

1個Port for 課程實作 
NodePort, tcp:30060

Windows 用戶製作自己的ssh key 並上傳到GCP可參考：https://www.techcoke.com/2017/01/google-compute-engine-putty-ssh-instances.html

課程實作上有相關問題，也可以到Issues上發單詢問。

## 使用kubeadmin 部署kubernetes 影片
[使用kubeadmin 部署kubernetes 影片](https://youtu.be/JjOekmoacBg)
## 使用kubespray 部署kubernetes 影片
[使用Kubespray 部署kubernetes 影片](https://youtu.be/n0HAqlphXMQ)

