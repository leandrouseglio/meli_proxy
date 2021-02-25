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
helm3 repo add bitnami https://charts.bitnami.com/bitnami
helm3 install kube-state-metrics bitnami/kube-state-metrics -n metrics
helm3 install metric-server bitnami/metrics-server --set apiService.create=true -n metrics

echo "\n"
echo "Setting up server nginx"
helm3 install mproxy -f values.yaml bitnami/nginx -n mproxy

echo "\n"
echo "Setting up hpa"
kubectl create -f hpa.yaml

exit 0