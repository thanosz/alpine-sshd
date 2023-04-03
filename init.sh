#!/usr/bin/env sh

if [[ ! -f /params/passwd ]]; then
	ssh-keygen -A
	cp -rvp /etc/ssh /params
	cp -vp /etc/passwd /etc/group /etc/shadow /params
fi
 
