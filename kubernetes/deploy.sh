#!/usr/bin/env bash

set -e

deployEnv=${DEPLOY_ENV}

kubectl replace configmap storage-manager-conf --from-file=../conf/${DEPLOY_ENV}/daf.conf
kubectl replace -f  daf-storage-manager-${DEPLOY_ENV}.yml --force
