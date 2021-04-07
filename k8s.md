# 深入淺出Container, Kubernetes and GKE: Kubernetes篇

## 安裝
### VM1 安裝rancher
#### 檢查，確保80, 443 ports是否有被佔用
```
docker ps -a
```
#### 有佔用情形，先停止佔用container 
```
docker stop {container_name}
```
#### 執行部署rancher腳本
```
sudo /home/demoyuw/k8s/rancher/ubunu16_deploy_rancher.sh
```
#### 驗證rancher container運作是否正常
```
docker ps -a
```

## VM2 部署all in one kubernetes 節點
### VM2 安裝docker
### 複製所有範例程式及腳本至VM2
```
git clone https://github.com/demoyuw/k8s.git
```
### 調整k8s內的所有檔案權限
```
sudo chmod 755 -R k8s/
```
### 執行安裝docker 腳本
```
sudo ~/k8s/rancher/ubunu16_install_docker.sh
```
### 檢視docker版本
```
docker -v
```
### Reload docker group 設定 (exit離開，重新ssh登入VM1)。
````
exit
ssh -i ~/.ssh/k8s.key demoyuw@xxx.xxx.xxx.xxx
````

### VM2部署kubernetes
```
sudo docker run -d --privileged --restart=unless-stopped --net=host -v /etc/kubernetes:/etc/kubernetes -v /var/run:/var/run  rancher/rancher-agent:v2.5.7 --server https://35.247.112.95 --token 7tnlbfhndzlzw8vw2hp4hb8nk665vr2m6g2488mdtrgthfjqp5v76f --ca-checksum 52a610fa49ce4f2cf8a56ecff2ac5bcc8ebf1852fdb78a9bfea46b5107ac1249 --etcd --controlplane --worker
```
#### 檢查kubernetes執行情況
```
docker ps -a
```

## VM1放置 kube config
### VM1 安裝 kubectl 指令
```
sudo snap install kubectl --classic
```
### 驗證kubectl 指令
```
kubectl version --client
```
### VM1 建立 .kube 資料夾
```
mkdir ~/.kube
```
### 檢查資料夾建立是否成功
```
ls -al ~/
```
### 移動至.kube資料夾內，準備建立config檔，並放入kubeconfig
```
cd ~/.kube
vim config
```
### 驗證kubectl
```
kubectl version
```

## 使用VM1 kubectl 部署nginx deployment
### 部署nginx deployment
```
kubectl apply -f ~/k8s/deployment/nginx/nginx-deploy.yaml
```
### 檢查deployment部署情況
```
kubectl get all
```

## 使用VM1 kubectl backend deployment
### 部署backend deployment
```
kubectl apply -f ~/k8s/deployment/backend/backend.yaml
```
### 檢查deployment部署情況
```
kubectl get all
```
