#!/bin/bash
mysql_oracle="bison bison-devel zlib zlib-devel libcurl libcurl-devel gnutls-devel libevent-devel libxml2-devel boost-devel libarchive-devel m4 Perl ncurses  ncurses-devel libaio libaio-devel openssl openssl-devel bzip2 glibc glibc-headers gmp-devel mpfr-devel libmpc-devel"

pg_packages="perl-ExtUtils-Embed pam-devel libxml2-devel libxslt libxslt-devel openldap openldap-devel python-devel python3-devel openssl-devel zlib-devel readline-devel "

toolkit_packages="perl-TermReadKey perl-ExtUtils-MakeMaker perl-CPAN  perl-DBI perl-DBD-MySQL perl-Time-HiRes perl-IO-Socket-SSL perl-Digest-MD5 perl-devel perl-ExtUtils*"

xtrabackup_packages="centos-release-scl scl-utils-build devtoolset-8-toolchain devtoolset-9-toolchain devtoolset-10-toolchain devtoolset-11-toolchain libtool vim-common python-sphinx libaio libaio-devel ncurses ncurses-devel libgcrypt-devel libev-devel libcurl-devel libgpg-error-devel libidn-devel perl-DBD-MySQL qpress"

php_packages="libxml2 libxml2-devel openssl openssl-devel openssl11 openssl11-devel libmcrypt libmcrypt-devel libicu libicu-devel zlib zlib-devel curl libcurl libcurl-devel bzip2 bzip2-devel libpng libpng-devel freetype freetype-devel gmp gmp-devel readline readline-devel  libxslt libxslt-devel  glibc glibc-devel  glib2 glib2-devel xmlrpc-c xmlrpc-c-devel ncurses ncurses-devel net-snmp net-snmp-devel openldap openldap-devel oniguruma oniguruma-devel krb5-devel gettext gettext-devel gettext-common-devel  GeoIP GeoIP-devel GeoIP-data trousers-devel e2fsprogs-devel uuid-devel libuuid-devel libffi-devel libXpm-devel postgresql-devel ImageMagick-devel  sqlite-devel gdbm-devel libX11-devel gd-devel expat-devel  libmemcached-devel php-mcrypt  icu fontconfig libtool  perl gperftools libblkid-devel fuse-devel libedit-devel libatomic_ops-devel"

pg_packages="lz4 lz4-devel python python-devel python3 python3-devel openldap openldap-devel tcl tcl-devel libxslt libxslt-devel libxml2 libxml2-devel pam pam-devel openssl openssl-devel zlib zlib-devel readline readline-devel perl-ExtUtils-Embed systemtap-sdt-devel.x86_64  "

basic_packages="gcc gcc-c++ make cmake cmake3 automake autoconf flex ntp lrzsz stress iotop dstat sysstat tk tk-devel  kernel-devel coreutils"

others=" xfsprogs smartmontools openjade qperf"

no_packages="mpstat krb5 libjpeg libjpeg-devel curl-devel db4-devel libudev-devel libtool-libs e4fsprogs jadetex"

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
	echo -e "\033[49;31;1m ------------------------------------------------------>>\033[0m"
	echo "Installed packages: ${installed[*]}"
	echo "Not found packages: ${not_found[*]}"
	echo "Failed packages: ${failed[*]}"
	echo -e "\033[49;31;1m ------------------------------------------------------>>\033[0m"

	if [ ${#installed[@]} -eq ${#packages[@]} ]; then
		return 0
	else
		#return 1
		exit 1
	fi
}

function main() {
	yum_install_packages $basic_packages      #>>packages.log
	yum_install_packages $toolkit_packages    #>packages.log
	yum_install_packages $xtrabackup_packages #>>packages.log
	yum_install_packages $mysql_oracle        #>>packages.log
	yum_install_packages $php_packages        #>>packages.log
	yum_install_packages $pg_packages         #>>packages.log
	yum_install_packages $others              #>>packages.log

}
main
