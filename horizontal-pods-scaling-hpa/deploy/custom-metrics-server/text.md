
> 
> Services need to be accessible via HTTP and **not** HTTPS.

Install the customised K8s prometheus server:

```plain
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
```{{exec}}


The modifications here were these arguments:

```yaml

```

and an updated  YAML:

```yaml{10,11}
prometheus:
  url: http://mon-kube-prometheus-stack-prometheus.monitoring.svc

rules:
  default: false
  custom:
  - seriesQuery: '{namespace="default",service="orion-app-service"}'
    resources:
      overrides:
        namespace:
          resource: "namespace"
        service:
          resource: "service"
    # name:
    #   matches: "(.*)"
    metricsQuery: 'avg(sum_over_time(total_hit_count{pod=~"orion-app-deploy-(.*)"}[2m])) by (service)'

```

> Add the helm repo:

```plain
helm repo add stable https://charts.helm.sh/stable
```{{exec}}

> update the chart repo:

```plain
helm repo update
```{{exec}}


> Create the namespace

```plain
kubectl create namespace monitoring```{{exec}}

> Simply install the repo
```plain
helm install mon \
      --namespace monitoring \
      prometheus-community/kube-prometheus-stack```{{exec}}
