#!/bin/bash

for ((i=33; i<=35; i++))
do
    gcloud compute --project=abackend15-pj3 instances create iisi-k8s-vm2-$i \
    --zone=us-east1-b --machine-type=e2-medium --subnet=default --network-tier=PREMIUM \
    --maintenance-policy=MIGRATE --service-account=224189083723-compute@developer.gserviceaccount.com \
    --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append \
    --tags=http-server,https-server --image=ubuntu-2004-focal-v20220712 --image-project=ubuntu-os-cloud \
    --boot-disk-size=20GB --boot-disk-type=pd-standard --boot-disk-device-name=iisi-k8s-vm2-$i
done
