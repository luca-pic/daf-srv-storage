#!/usr/bin/env bash

set -e

dhall-to-yaml --omitNull <<< ./service.dhall > daf-storage-manager.yml
echo --- >> daf-storage-manager.yml
dhall-to-yaml --omitNull <<< ./deployment.dhall >> daf-storage-manager.yml

kubectl --kubeconfig=$KUBECONFIG delete configmap storage-manager-conf || true
kubectl --kubeconfig=$KUBECONFIG create configmap storage-manager-conf --from-file=../conf/${DEPLOY_ENV}/daf.conf
kubectl --kubeconfig=$KUBECONFIG delete -f daf-storage-manager.yml || true
kubectl --kubeconfig=$KUBECONFIG create -f daf-storage-manager.yml
