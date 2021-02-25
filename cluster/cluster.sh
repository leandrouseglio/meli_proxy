#!/bin/bash

echo "\n"
echo "Setting up eks cluster"

terraform init

terraform apply

aws eks --region $(terraform output -raw region) update-kubeconfig --name $(terraform output -raw cluster_name)