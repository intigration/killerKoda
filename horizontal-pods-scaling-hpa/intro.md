# ORION autoscaling with custom metrics

In this demo we will deploy an ORION app  orion-app which will generate a count at `/metrics`. These metrics will be consumed by Prometheus. With the help of [`k8s-prometheus-adapter`](https://github.com/DirectXMan12/k8s-prometheus-adapter), we will create APIService `custom.metrics.k8s.io`, which then will be utilized by HorizotalPodsAutoScaler to scale the deployment of orion-app service (increase number of replicas).

## Prerequisite
- You have a running ORION Cluster and to access it.



## Installing Prometheus Operator and Prometheus

 ```plain
  git clone https://github.com/infracloudio/kubernetes-autoscaling.git
  cd kubernetes-autoscaling
  ```
  {{exec}}
Now, we will install [kube-prometheus-stack](https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack) chart. It will deploy [Prometheus Operator](https://github.com/coreos/prometheus-operator) and create an instance of Prometheus using it.

- Add prometheus-community Helm repository and create `monitoring` namespace.

  ```console
  $ helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
  "prometheus-community" has been added to your repositories
  
  $ helm repo add stable https://charts.helm.sh/stable
  "stable" has been added to your repositories
  
  $ helm repo update
  Hang tight while we grab the latest from your chart repositories...
  ...Successfully got an update from the "prometheus-community" chart repository
  ...Successfully got an update from the "stable" chart repository
  Update Complete. ⎈ Happy Helming!⎈ 

  $ kubectl create namespace monitoring
  namespace/monitoring created
  ```
- Install kube-prometheus-stack.

  This will install Prometheus Operator in the namespace `monitoring` and it will create [`CustomResourceDefinitions`](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/#customresourcedefinitions) for `AlertManager`, `Prometheus` and `ServiceMonitor` etc.
  ```
  $ helm install mon \
      --namespace monitoring \
      prometheus-community/kube-prometheus-stack
  ```
  