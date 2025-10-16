#!/bin/bash

flatpak-spawn --host sh -c 'PATH=/usr/sbin:$PATH; ptyxis -- /usr/bin/toolbox run -c dev-env nvim "$2"' -- "$0" "$@"
