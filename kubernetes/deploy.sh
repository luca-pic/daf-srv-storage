#!/usr/bin/env bash

set -e

kubectl --kubeconfig=$KUBECONFIG delete configmap storage-manager-conf --namespace=testci || true
kubectl --kubeconfig=$KUBECONFIG create configmap storage-manager-conf --from-file=../conf/${DEPLOY_ENV}/daf.conf --namespace=testci
kubectl --kubeconfig=$KUBECONFIG replace -f daf-storage-manager-${DEPLOY_ENV}.yml --force --namespace=testci
