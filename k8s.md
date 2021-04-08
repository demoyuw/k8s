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
### 顯示Kube config 所有cluster資訊 p.93
```
kubectl config get-contexts 
```
### 選擇使用指定的cluster
```
kubectl config use-context {cluster name}
kubectl config use-context rancher-k8s2-k8s-20210407-102
```
### 檢查Kubeconfig cluste資訊
```
kubectl config get-contexts 
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
## 除錯
### kubectl exec
```
kubectl exec -it {pod_name} -- /bin/bash
kubectl exec -it {pod_name} -c {container_name} -- /bin/bash
```
#### 範例
```
kubectl exec -it nginx-deployment-6b474476c4-dx2zl -- /bin/bash
kubectl exec -it backend-68ffbfb9cd-vjxk5 -c python -- /bin/bash
kubectl exec -it backend-68ffbfb9cd-vjxk5 -c mysql -- /bin/bash
```
##### 退出
```
exit
```
### kubectl logs p.110
```
kubectl logs {pod_name}
kubectl logs {pod_name} -c {container_name}
```
#### 範例
```
kubectl logs nginx-deployment-6b474476c4-dx2zl
kubectl logs backend-68ffbfb9cd-vjxk5 -c python
kubectl logs backend-68ffbfb9cd-vjxk5 -c mysql
```

### kubectl describe p.112, p114
```
kubectl describe pod {pod_name}
kubectl describe deployment {deployment_name}
kubectl describe rs {rs_name}
```
#### 範例
```
kubectl describe pod backend-68ffbfb9cd-vjxk5
kubectl describe deployment backend
kubectl describe rs backend-68ffbfb9cd
```

### 動態調整資源
```
kubectl edit deploy nginx-deployment --record=true
  replicas: 2
```
### 查詢deployment 版本紀錄
```
kubectl rollout history deployment nginx-deployment
```
### 回朔deployment到上一版本
```
kubectl rollout undo deployment nginx-deployment
```

### 部署DaemonSet p.118
```
kubectl apply -f ~/k8s/daemonset/daemonset.yaml
```
#### 檢查DaemonSet 
```
kubectl get daemonset --all-namespaces
kubectl describe po fluentd-elasticsearch-6gg5f -n kube-system
```
#### 檢查DaemonSet container 與log資訊
```
kubectl get pod -o wide --all-namespaces | grep fluentd-elasticsearc
kubectl exec -it fluentd-elasticsearch-6gg5f -n kube-system -- /bin/bash
kubectl exec -it fluentd-elasticsearch-6gg5f -n kube-system -- ls /var/lib/docker/containers
```

### 檢視節點資訊(VM) p.121
```
kubectl get nodes -o wide
```
#### 顯示節點上所有標籤
```
kubectl get nodes --show-labels
```
#### 節點上新增標籤 hardware=high-cpu p.122
```
kubectl label node {node name} hardware=high-cpu
```
#### 節點上移除標籤 hardware=high-cpu
```
kubectl label node {node name} hardware-
```

## kubenetet service
### 部署nginx service yaml
```
kubectl apply -f ~/k8s/deployment/nginx/nginx-service.yaml
kubectl apply -f ~/k8s/deployment/backend/python-service.yaml
```
#### 檢視部署的nginx service
```
kubectl get service
```
### 刪除deployment
```
kubectl delete deploy backend
```
### k8s selector p.132
```
kubectl get all --selector="app=nginx"
```

### k8s DNS p.133
```
kubectl get services kube-dns --namespace=kube-system
```
#### 驗證
```
kubectl run curl --image=radial/busyboxplus:curl -i --tty
nslookup nginx-service
```

### 顯示系統端資訊
```
kubectl get all --namespace=kube-system
```

## k8s ingress
### 部署ingress
```
kubectl apply -f k8s/ingrees/ingress.yaml
```
#### 檢查ingress狀態
```
kubectl get ingress
```
#### 檢查ingress狀態
```
curl http://nginx.{VM2 外部IP}.xip.io/nginx
```