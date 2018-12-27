# Moon Deployment Configuration

## One Command Deployment

1. Deploy [Moon](https://moon.aerokube.com/) cluster to a running [Kubernetes](https://kubernetes.io/) cluster with just **one command**:
```
$ kubectl apply -f moon.yaml
clusterrolebinding.rbac.authorization.k8s.io "moon-rbac" created
namespace "moon" created
service "moon" created
resourcequota "max-moon-sessions" created
deployment.apps "moon" created
configmap "quota" created
secret "users" created
secret "licensekey" created
```
2. Wait while LoadBalancer IP is allocated:
```
$ kubectl get svc -n moon
NAME      TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)                         AGE
moon      LoadBalancer   10.63.242.109   <pending>     4444:31894/TCP,8080:30625/TCP   17s
```
It will look like this when finished:
```
$ kubectl get svc -n moon
NAME      TYPE           CLUSTER-IP      EXTERNAL-IP      PORT(S)                         AGE
moon      LoadBalancer   10.63.242.109   104.154.161.58   4444:31894/TCP,8080:30625/TCP   1m
```
3. Create browser session using the following URL in test...
```
http://104.154.161.58:4444/wd/hub
```
... or with a `curl` command:
```
$ curl http://104.154.161.58:4444/wd/hub/session -d'{"desiredCapabilities":{"browserName":"firefox","enableVNC":true}}'
{"value":{"capabilities":{"acceptInsecureCerts":false,"browserName":"firefox","browserVersion":"61.0","moz:accessibilityChecks":false,"moz:headless":false,"moz:processID":44,"moz:profile":"/tmp/rust_mozprofile.T5LY03uKdmI9","moz:useNonSpecCompliantPointerOrigin":false,"moz:webdriverClick":true,"pageLoadStrategy":"normal","platformName":"linux","platformVersion":"4.4.111+","rotatable":false,"timeouts":{"implicit":0,"pageLoad":300000,"script":30000}},"sessionId":"firefox-61-0-5f309485-8e04-4dfe-b9c4-be25249d7102"}}
```
4. Moon web interface is available at:
```
http://104.154.161.58:8080/
```

## Installing License Key

By default this repository includes a license key to run up to 4 parallel Selenium sessions. To have more sessions you need to purchase a license key which looks like this:
```
$ cat ~/license.key
MG1RSVdpc2Z6YjdQQVZjd2lpei9KMkd1T3dzMTFuL1dlRjVSc3NOMUcxZk9QaUxWa3Q5SnBIakIxa09wWm0vVFJqQ0tsa21xVG1OODVRZnlQbjBjVmRHVWFLampTOFF1a3VLRXRPcEUwbnEySG16QWFQWHRDYTVjMm9jZzZFaUJqeFd5ODE4UFBHZzNCNWpCYXlha3oweFBscFl1RnB0V0U1Q3FwOGl5VDdKTk9abG5aSmlPdnRmZDFvSG1nNnVwVXBLV2E4RmYwWHcreERIR29ZTE1XTldPb1hvT2ZCUnZpcDhPWW05a1FqN0hBWWVOYUtLT1lPWlVJa1dsb1gxdjNOT1htTFpZalhsQ3h1Q3V6NWhiQjIwSjVIY0JTYnZybm9zYm14RXFkSFpQWVBKWUlKTzZvVlBnODhQeFErZ1EyTk5sWG82TC9XeXU3aisrNU0rSEdPcXlOSEdlNGx4Zm1nNVhjMWlnNkN1OCtNSVVYRzNqUllqOUY4ZHdReWpSbFNMNmFpL2dRQnc3TzY0U0lwdVF2d29jYi9kVzFSYWFRVkd3ZXYrOVdING8zRWRrYkVONUhRTmQ2MUxsUnFNdmtKeWVHV21tVlVUZ2dsMDRsTFFLTmZNVG81L2JVakNBMGhNeER5VHNJdmVRRGFMMklvTWpvcFk4VERlK1U2bUJvUDVxNVYrcCtDQVhjbjYxQlRaUVp0bmNqL0JBVkdNOEZ4NW9rWHRYSVAxUkY0a1VCckZVTDFyTWF1VkZqSk5xU1pLT293dUpMTTg2SEZ0Sld0eUlRK3ZZZm1pZU0xM292MnVleDBoRlhRdFkvMkt1dUhhN3dKV2pFT0pqaEVzTjhXSy82ZlFFbi9EQzcrNkw3NzhlbmVVZ2lLZ3VFbjlMMXZMYVZ5VWtQaWc9O2V5SnNhV05sYm5ObFpTSTZJa1JsWm1GMWJIUWlMQ0p3Y205a2RXTjBJam9pVFc5dmJpSXNJbTFoZUZObGMzTnBiMjV6SWpvMGZRPT0=
```
For example your key *contains 10 parallel sessions*. To install this key do the following:

1) Update secret in `moon.yaml`:
```yaml
apiVersion: v1
kind: Secret
metadata:
  name: licensekey
  namespace: moon
stringData:
  license.key: <new-key-contents-here> # Update this line
```
2) Increase pods limit in resource quota to `numSessions + numMoonReplicas` (you only pay for browser pods and can have any number of Moon replicas):
```yaml
apiVersion: v1
kind: ResourceQuota
metadata:
  name: max-moon-sessions
  namespace: moon
spec:
  hard:
    pods: "12" # 12 = 10 parallel sessions in license key + 2 Moon replicas 
  scopes: ["NotTerminating"]
``` 