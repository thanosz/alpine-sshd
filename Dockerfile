FROM alpine:3.21.3

RUN apk update && apk add --no-cache openssh screen nano iproute2 python3 tmux mosh \
		&& rm -rf /var/cache/apk/* /tmp/* /etc/motd

RUN sed -i 's/^AllowTcpForwarding.*/AllowTcpForwarding yes/g' /etc/ssh/sshd_config 
RUN sed -i 's/^X11Forwarding.*/X11Forwarding yes/g' /etc/ssh/sshd_config 
RUN sed -i 's/^GatewayPorts.*/GatewayPorts yes/g' /etc/ssh/sshd_config
RUN sed -i 's/^#ClientAliveInterval.*/ClientAliveInterval 30/g' /etc/ssh/sshd_config
RUN sed -i 's/^#ClientAliveCountMax.*/ClientAliveCountMax 3/g' /etc/ssh/sshd_config
RUN sed -i 's/^#Port 22/Port 2222/g' /etc/ssh/sshd_config

#COPY optional/10-disable-history.sh /etc/profile.d/
#COPY optional/20-logout.sh /etc/profile.d/
COPY entrypoint.sh /usr/local/bin

EXPOSE 2222

ENTRYPOINT ["entrypoint.sh"]
