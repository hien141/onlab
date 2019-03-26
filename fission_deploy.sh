#!/bin/bash

mkdir /mnt/data

kubectl create -f storageclass.yaml
kubectl create -f fission-storage1.yaml
kubectl create -f fission-storage2.yaml
kubectl create -f fission-storage3.yaml

curl -LO https://storage.googleapis.com/kubernetes-helm/helm-v2.11.0-linux-amd64.tar.gz

tar xzf helm-v2.11.0-linux-amd64.tar.gz
# Sudo kell ->
mv linux-amd64/helm /usr/local/bin
# Sudo nemkell ->
kubectl create serviceaccount --namespace kube-system tiller
# Sudo nemkell ->
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
# Sudo nem kell ->
#helm init --wait --service-account tiller
helm init --wait --upgrade --service-account tiller
##helm init -> csak akkor kell ha már van fent tiller és van servíz account nekik

# Ezt kell megvárni, hogy végezzen!!! és előtte hogy a thiller pod feléledjen!!! ->
helm install --name fission --namespace fission https://github.com/fission/fission/releases/download/1.0.0/fission-all-1.0.0.tgz

#helm install --name fission --namespace fission --set serviceType=NodePort,routerServiceType=NodePort https://github.com/fission/fission/releases/download/1.0.0/fission-all-1.0.0.tgz
#kubectl apply -f https://github.com/fission/fission/releases/download/1.0.0/fission-all-1.0.0.yaml

# CLI
curl -Lo fission https://github.com/fission/fission/releases/download/1.0.0/fission-cli-linux && chmod +x fission && sudo mv fission /usr/local/bin/
