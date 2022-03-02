-  #### Install Prometheus using Helm
```
helm install prometheus prometheus-community/kube-prometheus-stack
```
-  #### Install csv server using Helm
```
helm install csvserver-helm csv-server/ -f csv-server/values.yaml
```
