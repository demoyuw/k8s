# k8s

Ubuntu 16.04.02 LTS install kubernetes cluster 

------------
Master node
use ubuntu16installk8s_master.sh

slave node
use ubuntu16installk8s_slave.sh

------------
Kubernetes 微服務架構設計班

課程所提供VM規格為 GCP VM，規格為 n1-standard-1 (1 個 vCPU，3.75 GB 記憶體) 10G disk，防火牆支援HTTP and HTTPS，還在VPC的防火牆規則開了tcp:2379、tcp:10250、tcp:6443 for Kubernetes。

Windows 用戶製作自己的ssh key 並上傳到GCP可參考：https://www.techcoke.com/2017/01/google-compute-engine-putty-ssh-instances.html

課程實作上有相關問題，也可以到Issues上發單詢問。





