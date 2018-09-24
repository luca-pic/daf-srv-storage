#!/usr/bin/env bash

set -e

# deployEnv=$1

kubectl --kubeconfig=$KUBECONFIG delete configmap storage-manager-conf
kubectl --kubeconfig=$KUBECONFIG create configmap storage-manager-conf --from-file=../conf/${DEPLOY_ENV}/daf.conf
kubectl --kubeconfig=$KUBECONFIG replace -f daf-storage-manager-${DEPLOY_ENV}.yml --force
