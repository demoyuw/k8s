# 深入淺出Container, Kubernetes and GKE: docker篇

## Linux or Mac ssh 登入 GCP VM, 複製 k8s/ssh/k8s.key至筆電端
### 移動ssh key至 .ssh資料夾內 p.4
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
docker build {Dockerfile 所在位置} --tag {image_name}
```
#### build docker nginx
```
cd k8s/dockerfile/nginx
docker build . --tag demoyuw/nginx:v0.1
cd ~/
```
#### build python flask
```
docker build dockerfile/flask-api/ --tag demoyuw/flask-api
```
#### build ubuntu
```
docker build dockerfile/ubuntu16/ --tag demoyuw/ubuntu16
```
#### build java tomcat
```
docker build dockerfile/tomcat/ --tag demoyuw/java-tomcat 
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
### 登入docker hub p.32
```
docker login
```
### 上傳docker image 到 docker hub
```
docker push demoyuw/nginx:v0.1
```
### 抓取docker image from docker hub
#### 抓取私有帳號或組織的container image
```
docker pull demoyuw/nginx:v0.1
```
#### 抓取官方container image 
```
docker pull ubuntu:18.04
```
### docker container列表 p.33
```
docker ps -a
```
### 建立docker container 
#### -p: port, -v: Volume
### 建立nginx container
```
docker run -itd -p 80:80 --name nginx demoyuw/nginx:v0.1
```
### 建立python flask Container
```
docker run -itd -p 30060:10009 --name python-flask demoyuw/flask-api
```
#### 驗證 python-flask
```
http://{VM1 外部IP}:30060
```
### 建立 java tomcat container
```
docker run -v /home/demoyuw/k8s/dockerfile/tomcat/war:/apache-tomcat-7.0.82/webapps -p 80:8080 -itd --name java-tomcat demoyuw/java-tomcat
```
#### 驗證 java tomcat
```
http://{VM1 外部IP}/jenkins/
```

### 停止docker container p.35
```
docker stop {container_id or container_name}
```
#### 範例
```
docker stop nginx
docker stop acce9cce7388
docker stop java-tomcat
```
### 刪除 docker container
``` 
docker rm {container_id or container_name}
```
#### 範例
```
docker rm nginx
docker rm acce9cce7388
docker rm java-tomcat
```

### 至docker container 內執行 p.37
```
docker exec -it {container_id or container_name} {shell}
```
#### 範例
```
docker exec -it nginx /bin/bash
```
### 再docker container 內，退出docker container 
```
exit
```
### 丟command至docker container 內執行
```
docker exec -it {container_id or container_name} {command}
```
#### 範例
```
docker exec -it nginx ls /
```
### 取得docker cotainer stdout(標準輸出) 與 stderr(標準錯誤輸出)
```
docker logs {container_id or container_name}
```
#### 範例
```
docker logs nginx
```

## Docker Network
### None Network(移除網卡)
```
docker run -itd --net=none --name {container name} {container_id or container_name}
```
#### 範例
```
docker run -itd --net=none --name ubuntu16-none demoyuw/ubuntu16
```
#### 驗證
##### 進入docker container
```
docker exec -it ubuntu16-none /bin/bash
```
##### 取得網卡資訊
```
ip a s
```
##### 離開
```
exit
```

### Container Network(使用其他container網卡)
```
docker run -itd --net=container;{另一個container_name or container_id} --name {container name} {container_id or container_name}
```
#### 範例
##### container 1
```
docker run –itd --name ubuntu16 demoyuw/ubuntu16
```
##### container 2 （使用container1 網卡）
```
docker run -itd --net=container:ubuntu16 --name ubuntu16-container demoyuw/ubuntu16
```
#### 驗證
##### 進入docker container1
```
docker exec -it ubuntu16 /bin/bash
```
##### 顯示container1網卡資訊
```
ip a s
```
##### 進入docker container2
```
docker exec -it ubuntu16-container /bin/bash
```
##### 顯示container2網卡資訊
```
ip a s
```
##### 離開container1, container2
```
exit
```

### Host network(使用VM上的網卡)
```
docker run -itd --net=host --name {container name} {container_id or container_name}
```
#### 範例
##### 
```
docker run –itd --net=host --name ubuntu16-host demoyuw/ubuntu16
```
#### 驗證
##### 進入host network container
```
docker exec -it ubuntu16-host /bin/bash
```
##### 顯示host network container網卡資訊
```
ip a s
```
##### 離開
```
exit
```
##### 顯示VM網卡資訊
```
ip a s
```

## Docker Compose
### 在VM1 安裝
```
sudo apt install docker-ce-cli -y
sudo apt install docker-compose -y
```
### Command
#### Command 需至docker-compose.yaml 檔案所在位置執行
```
cd ~/k8s
```
#### 建立docker-compose image
```
docker-compose build
```
#### 建立docker-compose container 
##### (-d: daemon，背景執行)
```
docker-compose up -d
```
#### 列出docker-compose container 
```
docker-compose ps
```
#### 列出docker container 
```
docker ps -a
```
#### 進入docker-container進行操作
```
docker exec -it {container_name or container_id} {shell}
```
#### 關閉docker-compose container 
```
docker-compose down
```
