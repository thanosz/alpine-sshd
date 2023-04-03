#!/bin/sh

rm -r /etc/ssh /etc/passwd /etc/group /etc/shadow
ln -sf /params/ssh /etc/ssh
ln -sf /params/passwd /etc/passwd
ln -sf /params/group /etc/group
ln -sf /params/shadow /etc/shadow

# do not detach (-D), log to stderr (-e), passthrough other arguments
exec /usr/sbin/sshd -D -e "$@"
