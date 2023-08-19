#!/bin/bash
function install() {
	git clone git@github.com:mvdan/sh.git
	if [ ! -d sh ]; then
		echo "git clone git@github.com:mvdan/sh.git error"
		exit 1
	fi
	cd sh
	go install mvdan.cc/sh/v3/cmd/shfmt@latest
	cd cmd/shfmt/
	go build
	if [ -f /usr/bin/shfmt ]; then
		echo "/usr/bin/shfmt exists"
	else
		cp shfmt /usr/bin/shfmt
	fi
}
install
