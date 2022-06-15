#### Install Prometheus using Helm
```
helm install prometheus prometheus-community/kube-prometheus-stack
```
#### Install csv server using Helm
```
helm install csvserver-helm csv-server/ -f csv-server/values.yaml
```
#### Install loki-stack grafana
```
helm show values grafana/loki-stack > loki-stack.yaml
helm install loki-stack grafana/loki-stack --values loki-stack.yaml -n loki --create-namespace
```
