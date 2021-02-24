#!/bin/bash

echo "\n"
echo "Uninstall server metrics"
helm3 uninstall kube-state-metrics -n metrics
helm3 uninstall metric-server -n metrics

echo "\n"
echo "Uninstall server nginx"
helm3 uninstall mproxy -n mproxy

echo "\n"
echo "Delete configmaps"
kubectl delete configmap static-content-nginx

echo "\n"
echo "Remove up namespaces"
kubectl delete ns mproxy
kubectl delete ns metrics

exit 0