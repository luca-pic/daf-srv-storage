#!/usr/bin/env bash

set -e

deployEnv=$1

kubectl --kubeconfig=/var/lib/jenkins/.kube/config.teamdigitale-staging delete configmap storage-manager-conf
kubectl --kubeconfig=/var/lib/jenkins/.kube/config.teamdigitale-staging create configmap storage-manager-conf --from-file=../conf/${DEPLOY_ENV}/daf.conf
kubectl --kubeconfig=/var/lib/jenkins/.kube/config.teamdigitale-staging replace -f daf-storage-manager-${DEPLOY_ENV}.yml --force
