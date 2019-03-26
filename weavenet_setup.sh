#!/bin/bash

## Initialize Kubernetes
kubeadm init --ignore-preflight-errors=SystemVerification
mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config

## Apply WeaveNet CNI plugin
# apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"

curl -o weave.yaml https://cloud.weave.works/k8s/v1.8/net.yaml
kubectl apply -f weave.yaml

#
#kubectl apply -f https://git.io/weave-kube
