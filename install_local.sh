#!/bin/bash
# @author: Kurucz Gabor
# @description: Fission Installer
# @created: 2019-03-05
# @version: 1.0
# @origin: https://github.com/szefoka/openfaas_lab


# Variable(s)

# Script variable(s)
PID=$$
SCRIPTNAME="$(basename $0)"
WORKER_LIST="worker.list"
IP=""
TOKEN=""
HASH=""

## Send error messages to stderr
#function echo_err {
#	echo "Error: $@" >&2
#}

function wait_for_worker {
  while [[ "$(kubectl get nodes | grep Ready | grep none | wc -l)" -lt 1 ]];
  do
    sleep 1
  done
}

function wait_for_podnetwork {
  #podnetwork should be running on the master and at least one worker node
  while [[ "$(kubectl get pods -n kube-system | grep weave-net | grep Running | wc -l)" -lt 2 ]];
  do
    sleep 1
  done
}

## Check files from parameters
if [ ! -f $WORKER_LIST ]; then
	echo_err "Worker list file ($WORKER_LIST) not exists."
	exit 1
	else if [ ! -s $WORKER_LIST ]; then
		echo_err "Worker list file ($WORKER_LIST) is empty."
	fi
fi

## Setup Kubernetes
./deploys/kubernetes_install.sh

## Setup Weavenet
./deploys/weavenet_setup.sh
#wait_for_podnetwork


#IP=$(ip addr sh dev $(ip ro sh | grep default | awk '{print $5}') scope global | grep inet | awk '{split($2,addresses,"/"); print addresses[1]}'):6443
#IP=$(ifconfig $(route | grep '^default' | grep -o '[^ ]*$') | grep "ens1 addr:" | awk '{print $2}' | cut -c6-)
IP=$(ip addr sh dev $(ip ro sh | grep default | awk '{print $5}') scope global | grep inet | awk '{split($2,addresses,"/"); print addresses[1]}')
TOKEN=$(kubeadm token list | tail -n 1 | cut -d ' ' -f 1)
HASH=sha256:$(openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | openssl rsa -pubin -outform der 2>/dev/null | openssl dgst -sha256 -hex | sed 's/^.* //')


# Join the worker nodes
for LINE in $(cat $WORKER_LIST | grep -vE "^#"); do
	WORKERNAME=`echo $LINE | awk -F"/" '{print $NF}'`

	echo "[worker:$WORKERNAME] Deploying..."
	apt-get install -y sshpass
	sshpass -p '1234' ssh $WORKERNAME -o "StrictHostKeyChecking no" "bash -s" < mkdir /mnt/data
	sshpass -p '1234' ssh $WORKERNAME -o "StrictHostKeyChecking no" "bash -s" < ./deploys/kubernetes_install.sh true $IP:6443 $TOKEN $HASH
	wait_for_worker

	echo "[worker:$WORKERNAME] Deployment is completed."
done

## Setup Fission
./deploys/fission_deploy.sh

## Setup samples

./functions/functions_deploy.sh
