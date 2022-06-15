#!/bin/bash

# Istio
#istioctl install --set profile=demo -y
#kubectl label namespace default istio-injection=enabled

# Provision MetalLB LB
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.12.1/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.12.1/manifests/metallb.yaml
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: ConfigMap
metadata:
  namespace: metallb-system
  name: config
data:
  config: |
    address-pools:
    - name: default
      protocol: layer2
      addresses:
      - 172.18.255.1-172.18.255.250
EOF

# Nginx Ingress (specific to KinD clusters)
helm install ingress-nginx ingress-nginx  --version 4.0.17  --repo https://kubernetes.github.io/ingress-nginx  --set controller.hostPort.enabled=true  --
set controller.service.type=LoadBalancer --namespace ingress-nginx --create-namespace

 #### Install Prometheus using Helm
helm install prometheus prometheus-community/kube-prometheus-stack

#### Install csv server using Helm
helm install csvserver-helm csv-server/ -f csv-server/values.yaml

kubectl create secret tls tls-demo-secret --key csvserver.example.com.key --cert csvserver.example.com.crt
kubectl apply -f csv-server/templates/ingress.yaml

#curl -vsH "Host:csvserver.example.com" --resolve "csvserver.example.com:443:$INGRESS_IP" --cacert example.com.crt "https://csvserver.example.com
# Install Loki
helm install loki-stack grafana/loki-stack --values loki-stack.yaml -n loki --create-namespace
