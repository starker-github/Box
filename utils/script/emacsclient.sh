#!/bin/bash
if [ $# -eq 1 ];then
	emacs -q --eval "(setq server-base \"/ssh:""$1"":.emacs.d/\"))" --eval '(load (concat server-base "init-server.el"))' 1>&2 2>/dev/null &
else
	echo "Usage: $0 <user@ip-address>"
fi
