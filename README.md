# Simple Repo for custom or master dapr charts

## How to build and push new version

```bash
./package-and-push.sh
```

## How to install

```bash
helm repo add filintod-dapr https://filintod.github.io/dapr-charts
helm repo update
helm install -n dapr-system --create-namespace --version 1.15.0-master-5 dapr filintod-dapr/dapr 
```
