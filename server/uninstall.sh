#!/bin/bash

echo "\n"
echo "Uninstall server metrics"
helm uninstall kube-state-metrics -n metrics
helm uninstall metric-server -n metrics

echo "\n"
echo "Uninstall server nginx"
helm uninstall mproxy -n mproxy

echo "\n"
echo "Delete configmaps"
kubectl delete configmap static-content-nginx

echo "\n"
echo "Remove up namespaces"
kubectl delete ns mproxy
kubectl delete ns metrics

exit 0
