FROM alpine:3.17

RUN apk update && apk add --no-cache openssh screen nano iproute2 python3 tmux \
		&& rm -rf /var/cache/apk/* /tmp/* /etc/motd

#RUN adduser -D guest_user && echo 'guest_user:guest_user_pass' | chpasswd 
RUN sed -i 's/^AllowTcpForwarding.*/AllowTcpForwarding yes/g' /etc/ssh/sshd_config 
RUN sed -i 's/^X11Forwarding.*/X11Forwarding yes/g' /etc/ssh/sshd_config 
RUN sed -i 's/^GatewayPorts.*/GatewayPorts yes/g' /etc/ssh/sshd_config

#COPY 10-disable-history.sh /etc/profile.d/
#COPY 20-logout.sh /etc/profile.d/
COPY entrypoint.sh init.sh /usr/local/bin/

ENTRYPOINT ["entrypoint.sh"]
