#!/bin/bash
python_version='3.10.11'
python_basedir="/usr/local/python-${python_version}"
python_bindir="/usr/local/python-${python_version}/bin"
packages="libffi-devel wget gcc make zlib-devel openssl openssl-devel openssl11 openssl11-devel ncurses-devel openldap-devel gettext bzip2-devel gdbm-devel uuid-devel xz-devel sqlite-devel readline-devel tk-devel"

function yum_install_packages() {
	# 将输入的软件包名称存储到数组中
	packages=("$@")

	installed=() # 存储已安装的软件包
	not_found=() # 存储不存在的软件包
	failed=()    # 存储安装失败的软件包

	for pkg in "${packages[@]}"; do
		if yum list installed "$pkg" >/dev/null 2>&1; then
			installed+=("$pkg")
			echo "$pkg already installed"
		else
			if yum list available "$pkg" >/dev/null 2>&1; then
				yum install -y "$pkg"
				if [ $? -eq 0 ]; then
					installed+=("$pkg")
					echo "$pkg installed successfully"
				else
					failed+=("$pkg")
					echo "$pkg installation failed"
				fi
			else
				not_found+=("$pkg")
				echo "$pkg not found in any repository"
			fi
		fi
	done
	echo "=============================================="
	echo "Installed packages: ${installed[*]}"
	echo "Not found packages: ${not_found[*]}"
	echo "Failed packages: ${failed[*]}"
	echo "=============================================="

	if [ ${#installed[@]} -eq ${#packages[@]} ]; then
		return 0
	else
		#return 1
		exit 1
	fi
}

function init_env() {
	rm -rf ${python_basedir}
	mkdir -p ${python_basedir}

}

# download from www.python.org/ftp
function download_python() {
	rm -rf Python-${python_version}
	if [ -f "Python-${python_version}.tar.xz" ]; then
		return 0
	fi
	echo "download_python ..."
	if [ -f "Python-${python_version}.tar.xz" ]; then
		echo "Python-${python_version}.tar.xz exists ..."
	else
		echo "download ..."
		wget "https://www.python.org/ftp/python/${python_version}/Python-${python_version}.tar.xz"
	fi
}

function install_python() {
	# 设置 C 编译器标志
	CFLAGS="$(pkg-config --cflags openssl11)"
	export CFLAGS
	# 设置LDFLAGS 链接器标志，
	LDFLAGS="$(pkg-config --libs openssl11)"
	export LDFLAGS
	echo "install_python ..."
	tar -xvJf Python-${python_version}.tar.xz
	cd Python-${python_version} || (echo "Python-${python_version} not exists" && exit 1)
	# 配置python可执行文件的后缀：--with-suffix=""
	# --with-ensurepip=install ：运行 python -m ensurepip --altinstall 命令
	# --enable-shared 启用共享 Python 库 libpython 的编译（默认为禁用），编译postgresql时，若想要支持PL/python,则必须开启该链接器选项
	# --with-openssl=/usr/local/openssl 解决Can‘t connect to HTTPS URL because the SSL 的报错
	# --with-openssl-rpath=auto

	./configure --prefix=${python_basedir} --enable-optimizations --enable-shared --with-suffix="" --with-ensurepip=install
	make -j $(nproc)
	make install
	#
	cat >/etc/ld.so.conf.d/python-${python_version}.conf <<EOF
${python_basedir}/lib
EOF
	ldconfig
	${python_bindir}/python3 -V
	if [ $? == 0 ]; then
		echo "install success ..."
	else
		exit 1
	fi

}

function ln_python() {
	echo "ln_python ..."
	rm -rf /usr/bin/python3-${python_version} /usr/bin/pip3-${python_version}
	ln -fs ${python_bindir}/python3 /usr/bin/python3-${python_version}
	ln -fs ${python_bindir}/pip3 /usr/bin/pip3-${python_version}

}

function pip_config() {
	mkdir -p ~/.pip
	#
	cat >~/.pip/pip.conf <<EOF
[global]
index-url=http://mirrors.aliyun.com/pypi/simple/
extra-index-url=
	https://pypi.tuna.tsinghua.edu.cn/simple/
        http://pypi.douban.com/simple/
	https://pypi.org/simple
# proxy = [user:passwd@]proxy.server:port
[install]
trusted-host=
        mirrors.aliyun.com
        pypi.tuna.tsinghua.edu.cn
        pypi.douban.com
ssl_verify: false

EOF

}

function main() {
	yum_install_packages $packages
	cd soft
	init_env
	download_python
	install_python
	ln_python
	pip_config
}

main
