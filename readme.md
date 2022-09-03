# Log monitoring setup for kubernetes pods

## Setup configuration
For setup please follow `setup.md` file residing in same directory.

## Logs monitoring
Below are some alises & its usage examples

- `ktx` is for context info. usage `ktx env`
- `kns` is for namespace info. usage `kns <service-name>`.
- `kpd` is for listing pods in current namespace. usage `kpd --namespace=<service-name>`
- `kpdns` is for listing pods in current namespace with some details. usage `kpdns <service-name>`
- `kexec` is for getting inside pod shell. usage `kexec <pod_id> --stdin --tty -- /bin/bash`
- `kexexs` is for getting inside pod shell with only single command. usage `kexecs <pod_id>`
- `ktail` is for log. usage `ktail <pod_id>` or `ktail <product_name or initial_pod_name>`
- `ktailn` is for log by pod serial number. usage `ktailn <number>`
<!-- - `klgp` is for log. usage `klgs <service_namespace_name>`
- `klga` is for log. usage `klgs <service_namespace_name> <max_concurrent_pods_count>` -->



---


### Examples:

```
$ ktx env
Switched to context "env".

$ kns dummy-service
Context "env" modified.
Active namespace is "dummy-service".

$ kpdns dummy-service
NAME                                      READY   STATUS    RESTARTS   AGE    LABELS
dummy-service-5f69bcf6fd-5ftdv   1/1     Running   0          3h9m   app.kubernetes.io/instance=dummy-service,app.kubernetes.io/name=dummy-service,pod-template-hash=5f69bcf6fd,product=dummy-service
dummy-service-5f69bcf6fd-5x76b   1/1     Running   0          3h9m   app.kubernetes.io/instance=dummy-service,app.kubernetes.io/name=dummy-service,pod-template-hash=5f69bcf6fd,product=dummy-service

$ ktail dummy-service-5f69bcf6fd-5ftdv
logs of single pod

$ ktail dummy-service
logs from all pods in one concurrent stream
```