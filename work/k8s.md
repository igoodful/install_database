



```bash
# deployment
kubectl get deployment  -A
kubectl delete deployment mysql -n igoodful




# pod

kubectl delete pod -A
kubectl delete pod mysql -n igoodful




# service
kubectl get svc -A
kubectl delete svc mysql -n igoodful

# statefulset
kubectl get statefulset -A


# storageclass
kubectl get storageclass -A


# pv
kubectl create -f pv.yaml
kubectl get pv
kubectl delete pv pv-name

# pvc
kubectl get pvc
kubectl describe pvc nfs-pvc
kubectl delete pvc pvc-name -n namespace
```























































