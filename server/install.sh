#!/bin/bash

echo "\n"
echo "Setting up namespaces"
kubectl create ns mproxy
kubectl create ns metrics

echo "\n"
echo "Setting up server content configmaps"
kubectl create configmap static-content-nginx --from-file nginx.conf


echo "\n"
echo "Setting up server metrics"
helm repo add bitnami https://charts.bitnami.com/bitnami
helm install kube-state-metrics bitnami/kube-state-metrics -n metrics
helm install metric-server bitnami/metrics-server --set apiService.create=true -n metrics

echo "\n"
echo "Setting up server nginx"
helm install mproxy -f values.yaml bitnami/nginx -n mproxy

echo "\n"
echo "Setting up hpa"
kubectl create -f hpa.yaml

exit 0
