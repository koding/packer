#!/bin/bash

export SHELLOPTS

source /etc/profile

for i in "$(dirname $BASH_SOURCE[0])"/env/*.sh; do
	if [ -r "$i" ]; then
		if [ "${-#*i}" != "$-" ]; then
			. "$i"
		else
			. "$i" >/dev/null 2>&1
		fi
	fi
done
