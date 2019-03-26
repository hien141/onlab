#!/bin/bash

CLIENT=$1
IP=$2
TOKEN=$3
HASH=$4


#Installing Docker
DOCKER_INSTALLED=$(which docker)
if [ "$DOCKER_INSTALLED" = "" ]
then
	#apt-get remove docker docker-engine docker.io
	apt-get update
	apt-get install -y apt-transport-https ca-certificates curl software-properties-common
	#apt-get upgrade -y #Tilos használni külső szervereken
	#apt-get install software-properties-common -y #kell a netes verzióhoz
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
	add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
	apt-get update
	#apt-get install -y docker-ce
	#apt-cache policy ( lekérdezni milyen veziók vannak még )
	#apt-get install -y docker-ce=18.06.0~ce~3-0~ubuntu
	#apt-get install -y docker-ce-cli=
	apt-get install -y docker-ce=5:18.09.3~3-0~ubuntu-bionic
	#apt-get install -y docker-ce-cli=5:18.09.0~3-0~ubuntu-xenial containerd.io
	#apt-get install -y docker-ce-cli=5:18.09.0~3-0~ubuntu-bionic containerd.io
	#apt-get install docker.io -y
	systemctl start docker
	systemctl enable docker
	systemctl enable docker.service
	#sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add
fi


#Installing Kubernetes
KUBERNETES_INSTALLED=$(which kubeadm)
if [ "$KUBERNETES_INSTALLED" = "" ]
then
	curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
	#touch /etc/apt/sources.list.d/kubernetes.list
	touch –c /etc/apt/sources.list.d/kubernetes.list
	#chmod 666 /etc/apt/sources.list.d/kubernetes.list
	# Ez a régi cuccos
	echo 'deb http://apt.kubernetes.io/ kubernetes-xenial main ' > /etc/apt/sources.list.d/kubernetes.list
	# Nincs még kiadva
	#echo 'deb http://apt.kubernetes.io/ kubernetes-bionic main ' > /etc/apt/sources.list.d/kubernetes.list
	# legfrissebb de szar
	#echo 'deb http://apt.kubernetes.io/ kubernetes-yakkety main ' > /etc/apt/sources.list.d/kubernetes.list
	
	apt-get update -y
	# xenialhoz készült
	apt-get install -y kubelet=1.13.4-00 kubeadm=1.13.4-00 kubectl=1.13.4-00 kubernetes-cni=0.6.0-00
	#apt-get install -y kubelet 1.13 kubeadm 1.13 kubectl 1.13 kubernetes-cni 1.13
fi

#Disabling swap for Kubernetes
sysctl net.bridge.bridge-nf-call-iptables=1 > /dev/null
swapoff -a

if [ -z "$CLIENT" ]
then
#	kubeadm init --ignore-preflight-errors=SystemVerification
#	mkdir -p $HOME/.kube
#	cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
#	chown $(id -u):$(id -g) $HOME/.kube/config
	:

elif [ "$CLIENT" = "true" ]
then
	kubeadm join $IP --token $TOKEN --discovery-token-ca-cert-hash $HASH --ignore-preflight-errors=SystemVerification
	echo "Client ($IP) joined to Master"
else
	echo "Invalid argument"
fi
