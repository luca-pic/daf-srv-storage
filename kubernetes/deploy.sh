#!/usr/bin/env bash

set -e

kubectl --kubeconfig=$KUBECONFIG delete configmap storage-manager-conf -n testci || true
kubectl --kubeconfig=$KUBECONFIG create configmap storage-manager-conf -n testci --from-file=../conf/${DEPLOY_ENV}/daf.conf
kubectl --kubeconfig=$KUBECONFIG replace -f daf-storage-manager.yml -n testci --force
