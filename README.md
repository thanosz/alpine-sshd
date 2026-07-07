# alpine-sshd

A lightweight SSH server container based on Alpine Linux, designed for secure SSH tunneling, port forwarding, and X11 forwarding in Docker and Kubernetes environments.

## Features

- **SSH Tunneling & Port Forwarding**: Full support for local and remote port forwarding
- **X11 Forwarding**: Enable graphical application forwarding over SSH
- **Gateway Ports**: Allow remote hosts to connect to forwarded ports
- **Keep-Alive**: Automatic connection maintenance with configurable intervals
- **Multi-Architecture**: Supports ARM (v6, v7, v8) and x86_64 platforms

### SSH Configuration

The server is pre-configured with the following options:

```
AllowTcpForwarding yes
GatewayPorts yes
X11Forwarding yes
ClientAliveInterval 30
ClientAliveCountMax 3
```

## Supported Platforms

Container images are available on Docker Hub for:

- `linux/arm/v6` (Raspberry Pi Zero, 1)
- `linux/arm/v7` (Raspberry Pi 2, 3)
- `linux/arm64/v8` (Raspberry Pi 4, 5)
- `linux/amd64` (x86_64)

## Quick Start

### Docker Deployment

Use the provided `docker-compose.yml`:

```bash
docker-compose up -d
```

### Kubernetes Deployment

Deploy using the provided manifests:

```bash
kubectl apply -f ssh-server.yaml
```

**Note**: The default configuration uses Rancher's `local-path` StorageClass. Modify this in the YAML file to match your cluster's storage provider.

## User Management

Users must be created manually after deployment. SSH access requires a user account with a password or SSH key.

### Create a User

**Docker:**
```bash
docker exec -it <container-name> adduser theUser
```

**Kubernetes:**
```bash
kubectl exec -it <pod-name> -- adduser theUser
```

Follow the prompts to set a password for the new user.

## Use Cases

### SSH Tunneling from Restricted Networks

This container is ideal for accessing systems behind firewalls or NAT by establishing reverse SSH tunnels.

**Example Scenario**: Access a server on a restricted network from your home network.

1. **From the restricted server**, establish a reverse tunnel to your home:
   ```bash
   ssh -N -R 9090:localhost:22 user@yourhomedomain
   ```
   This forwards the restricted server's SSH port (22) to port 9090 on your home server.

2. **From your home network**, connect to the restricted server:
   ```bash
   ssh -p 9090 user_on_restricted_server@yourhomedomain
   ```

### Port Forwarding

Forward any TCP service through the SSH tunnel:

```bash
# Forward remote MySQL to local port
ssh -L 3306:localhost:3306 user@yourhomedomain

# Forward local web server to remote port
ssh -R 8080:localhost:80 user@yourhomedomain
```

## Development Notes

This project was developed and tested on Raspberry Pi running K3s, making it ideal for edge computing and home lab environments where lightweight, multi-architecture support is essential.

## License

This project is open source. Please check the repository for license details.