#! /bin/bash

for ((i=81; i<=84; i++))
do
    gcloud compute --project=k8s-cluster3-276411 instances create k8s-20200507-$i \
    --zone=us-central1-a --machine-type=n1-standard-1 --subnet=default --network-tier=PREMIUM \
    --maintenance-policy=MIGRATE --service-account=478327229581-compute@developer.gserviceaccount.com \
    --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append \
    --tags=http-server,https-server --image=ubuntu-1604-xenial-v20200429 --image-project=ubuntu-os-cloud \
    --boot-disk-size=10GB --boot-disk-type=pd-standard --boot-disk-device-name=k8s-20200527-$i
done
