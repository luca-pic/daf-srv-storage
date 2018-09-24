#!/usr/bin/env bash

set -e

deployEnv=$1
kubeconf=$2

kubectl delete configmap storage-manager-conf
kubectl create configmap storage-manager-conf --from-file=../conf/${DEPLOY_ENV}/daf.conf
kubectl --kubeconfig=$kubeconf replace -f daf-storage-manager-${DEPLOY_ENV}.yml --force
