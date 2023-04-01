#!/bin/bash
function init_env(){
	python_version='3.9.10'
	python_basedir="/usr/local/python-${python_version}"
	python_bindir="/usr/local/python-${python_version}/bin"

}

function init_dep(){
	mkdir -p ${python_basedir}
	yum -y  install libffi-devel wget gcc make zlib-devel openssl openssl-devel ncurses-devel openldap-devel gettext bzip2-devel xz-devel

}

# download from www.python.org/ftp
function download_python(){
	if [ -f "Python-${python_version}.tar.xz" ]
	then
		echo "Python-${python_version}.tar.xz exists ..."
	else
		echo "download ..."
		wget "https://www.python.org/ftp/python/${python_version}/Python-${python_version}.tar.xz"
	fi
}

function install_python(){
	tar -xvJf Python-${python_version}.tar.xz
	cd Python-${python_version}
	./configure --prefix=${python_basedir}
	make
	make install
	${python_bindir}/python3 -V
	if [ $? == 0 ]
	then
		echo "install success ..."
	else
		exit 1
	fi

}

function ln_python(){
	ln -fs ${python_bindir}/python3 /usr/bin/python3-${python_version}
	ln -fs ${python_bindir}/pip3 /usr/bin/pip3-${python_version}
	pip3-${python_version} install virtualenv -i https://pypi.tuna.tsinghua.edu.cn/simple
	ln -fs ${python_bindir}/virtualenv /usr/bin/virtualenv-${python_version}

}


function main(){
	init_env
	init_dep
	download_python
	install_python
	ln_python
}

main


