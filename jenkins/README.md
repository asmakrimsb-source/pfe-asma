# Jenkins on Kubernetes (manifests)

This folder contains Kubernetes manifests to deploy Jenkins in the `jenkins` namespace with persistent storage.

## Apply

```bash
kubectl apply -f jenkins/namespace.yaml
kubectl apply -f jenkins/pv.yaml
kubectl apply -f jenkins/pvc.yaml
kubectl apply -f jenkins/deployment.yaml
kubectl apply -f jenkins/service.yaml
```

## Notes

- `pv.yaml` uses `hostPath` for local clusters (like this Vagrant setup). The PV is tied to the node where the Jenkins pod runs.
- `deployment.yaml` installs Ansible on container start (simple approach for labs).
- `service.yaml` exposes Jenkins via a NodePort.
