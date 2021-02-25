# meli_proxy

## prerequisitos
- `Terraform` "~> 0.14"
- `awscli`
- `kubectl` "Kubernetes 1.12+"
- `helm` "3.1.0"

```
$ aws configure
AWS Access Key ID [None]: YOUR_AWS_ACCESS_KEY_ID
AWS Secret Access Key [None]: YOUR_AWS_SECRET_ACCESS_KEY
Default region name [None]: YOUR_AWS_REGION
Default output format [None]: json
```

## crear infraestructura using terraform - eks
```
$ terraform init

$ terraform apply

$ aws eks --region $(terraform output -raw region) update-kubeconfig --name $(terraform output -raw cluster_name)
```

## deployar nginx server and metrics using helm3
```
$ helm3 install mproxy -f values.yaml bitnami/nginx -n mproxy

$ helm3 install kube-state-metrics bitnami/kube-state-metrics -n metrics

$ helm3 install metric-server bitnami/metrics-server --set apiService.create=true -n metrics
```

### Referencias
- https://learn.hashicorp.com/terraform
- https://helm.sh/docs/intro/install/
- https://artifacthub.io/packages/helm/bitnami/nginx
- https://artifacthub.io/packages/helm/bitnami/kube-state-metrics
- https://artifacthub.io/packages/helm/bitnami/metrics-server
