# sshd-alpine
sshd-alpine is a an SSH server for docker or kubernetes to allow X11 and tcp forwarding and ssh tunneling.

It comes with the following sshd options enabled

```
AllowTcpForwarding yes
GatewayPorts yes
X11Forwarding yes
ClientAliveInterval 30
ClientAliveCountMax 3
```

Primary goal is to allow forwarding traffic

The concept is that you deploy it and setup users which can later be used for ssh tunneling, port forwarding, etc. The users must be created by runinng standard linux commands.

```
docker exec -it <container-name> adduser theUser
kubectl exec -it <pod-name> -- adduser theUser
```

This can either run in docker with the provided docker-compose.yaml or in a k8s cluster (this was developed on k3s) taking care to modify the StorageClass used (by default is using rancher's local-path).

This was developed on Raspberry-pi to easily access restricted networks from which you initiate an ssh connection to your home router and instructing ssh to remote forward the restricted ssh port.


From the server on the restriced network
```
ssh -N -R9090:localhost:22 user@yourhomedomain
```

and then

```
ssh -p9090 user_on_restricted_server@yourhomedomain
```

The container images are hosted in dockerhub for the following platforms. The images should run on all raspberry pis, x86_64 and arm64 (aarch64) architecures

```
linux/arm/v6
linux/arm/v7
linux/arm64/v8
linux/amd64
```
