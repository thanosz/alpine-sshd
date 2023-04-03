#!/bin/sh

if [[ ! -f /params/passwd ]]; then
	ssh-keygen -A
	cp -rvp /etc/ssh /params
	cp -vp /etc/passwd /etc/group /etc/shadow /params
fi

rm -r /etc/ssh /etc/passwd /etc/group /etc/shadow
ln -sf /params/ssh /etc/ssh
ln -sf /params/passwd /etc/passwd
ln -sf /params/group /etc/group
ln -sf /params/shadow /etc/shadow

# do not detach (-D), log to stderr (-e), passthrough other arguments
exec /usr/sbin/sshd -D -e
