# moon-deploy

Deploy Moon cluster to any kubernetes engine with just **one command**:
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

Wait while LoadBalancer IP is allocated:
```
$ kubectl get svc -n moon
NAME      TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)                         AGE
moon      LoadBalancer   10.63.242.109   <pending>     4444:31894/TCP,8080:30625/TCP   17s
```
Now that it:
```
$ kubectl get svc -n moon
NAME      TYPE           CLUSTER-IP      EXTERNAL-IP      PORT(S)                         AGE
moon      LoadBalancer   10.63.242.109   104.154.161.58   4444:31894/TCP,8080:30625/TCP   1m
```
Create browser session with this curl command:
```
$ curl http://104.154.161.58:4444/wd/hub/session -d'{"desiredCapabilities":{"browserName":"firefox","enableVNC":true}}'
{"value":{"capabilities":{"acceptInsecureCerts":false,"browserName":"firefox","browserVersion":"61.0","moz:accessibilityChecks":false,"moz:headless":false,"moz:processID":44,"moz:profile":"/tmp/rust_mozprofile.T5LY03uKdmI9","moz:useNonSpecCompliantPointerOrigin":false,"moz:webdriverClick":true,"pageLoadStrategy":"normal","platformName":"linux","platformVersion":"4.4.111+","rotatable":false,"timeouts":{"implicit":0,"pageLoad":300000,"script":30000}},"sessionId":"firefox-61-0-5f309485-8e04-4dfe-b9c4-be25249d7102"}}
```
Access Moon's web interface on this url:
```
http://104.154.161.58:8080
```
