# 深入淺出Container, Kubernetes and GKE

## Linux or Mac ssh 登入 GCP VM, 複製 k8s/ssh/k8s.key至筆電端 p.4
### 移動ssh key至 .ssh資料夾內
``` 
mv k8s.key ~/.ssh/ 
```
### 調整k8s key檔案權限，改成只有root可以讀寫
```
chmod 600 ~/.ssh/k8s.key 
```
### 使用ssh key 遠端連線到GCP上的VM
```
ssh -i ~/.ssh/k8s.key demoyuw@xxx.xxx.xxx.xxx
```

## VM1 安裝docker p.16
### 複製所有範例程式及腳本至VM1 
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

## Docker command 操作
### 建立docker image p.29
```
cd k8s/dockerfile/nginx
docker build . --tag demoyuw/nginx:v0.1
```
### 檢視Dockcer image 清單
```
docker image ls -a
```
### docker image 加新的tag p.30
```
docker tag {image_id} demoyuw/nginx
```
### 刪除指定docker image
```
docker rmi {image_id or image_name}
```
#### 範例
```
docker rmi 5597fe68c7b4
docker rmi demoyuw/nginx:v0.1
```
### docker image 匯出成單一檔案
```
docker save -o {output_file.tgz} {docker_image_id or image_name}
```
#### 範例
```
docker save -o demoyuw_nginx.tgz demoyuw/nginx:v0.1
docker save -o 41eb0da21074.tgz 41eb0da21074
```

### docker image 匯入成單一檔案
```
docker load -i {output_file.tgz}
```
#### 範例
```
docker save -i demoyuw_nginx.tgz
docker save -i 41eb0da21074.tgz
```