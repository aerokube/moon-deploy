## Moon Helm Chart

```
$ helm upgrade --install --set=moon.enabled.resources=false service.externalIPs[0]=$(minikube ip) -n moon moon moon
```
