## Chart variables
| Name                |      Comment      |
|---------------------|-------------------|
| ingress.host        | Moon web interface endpoint. Default: moon.example.com. |
| service.externalIPs | Kubernetes node IPs assigned to LoadBalancer. Empty if deployed on AWS or GCE. |
| licenseKey          | Plain license text. Request yours at https://moon.aerokube.com/. |
| parallelSessions    | Amount of parallel sessions allowed by license + number of Moon replicas. |

## Sample deploy command
```
$ cd helm
$ helm upgrade moon . --install \
  --namespace moon \
  --set ingress.host=moon.mobbtech.com \
  --set licenseKey='<...>' \
  --set parallelSessions=1002
```