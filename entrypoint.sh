#!/bin/sh

if [[ ! -f /params/ssh/ssh_host_rsa_key.pub ]]; then
	ssh-keygen -A
	mkdir -p /params/ssh
	cp -rvp /etc/ssh /params
	cp -vp /etc/passwd /etc/group /etc/shadow /params
fi

rm -rf /etc/ssh /etc/passwd /etc/group /etc/shadow
ln -sf /params/ssh /etc/ssh
ln -sf /params/passwd /etc/passwd
ln -sf /params/group /etc/group

syslog-ng --no-caps -F &
tail -F /var/log/auth.log &
exec /usr/sbin/sshd -D
