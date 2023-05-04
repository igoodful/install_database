#!/bin/bash
mysql_oracle="bison bison-devel zlib zlib-devel libcurl libcurl-devel gnutls-devel libevent-devel libxml2-devel boost-devel libarchive-devel m4 autoconf make cmake gcc gcc-c++  Perl ncurses  ncurses-devel libaio libaio-devel openssl openssl-devel bzip2 glibc glibc-headers gmp-devel mpfr-devel libmpc-devel"
pg_packages="perl-ExtUtils-Embed pam-devel libxml2-devel libxslt-devel openldap-devel python-devel python3-devel openssl-devel zlib-devel readline-devel "
toolkit_packages="perl-TermReadKey perl-ExtUtils-MakeMaker perl-CPAN  perl-DBI perl-DBD-MySQL perl-Time-HiRes perl-IO-Socket-SSL perl-Digest-MD5"
xtrabackup_packages="centos-release-scl scl-utils-build devtoolset-8-toolchain devtoolset-9-toolchain devtoolset-10-toolchain devtoolset-11-toolchain cmake cmake3 gcc gcc-c++ automake autoconf bison libtool vim-common python-sphinx libaio libaio-devel ncurses ncurses-devel libgcrypt-devel libev-devel libcurl-devel libgpg-error-devel libidn-devel perl-DBD-MySQL qpress"
php_packages="libxml2 libxml2-devel openssl openssl-devel libmcrypt libmcrypt-devel libicu libicu-devel zlib zlib-devel curl curl-devel libcurl libcurl-devel bzip2 bzip2-devel libjpeg libjpeg-devel libpng libpng-devel freetype freetype-devel gmp gmp-devel readline readline-devel  libxslt libxslt-devel  glibc glibc-devel  glib2 glib2-devel xmlrpc-c xmlrpc-c-devel ncurses ncurses-devel net-snmp net-snmp-devel openldap openldap-devel oniguruma oniguruma-devel  krb5 krb5-devel gettext gettext-devel gettext-common-devel  GeoIP GeoIP-devel GeoIP-data trousers-devel e2fsprogs-devel uuid-devel libuuid-devel libffi-devel libXpm-devel postgresql-devel ImageMagick-devel  sqlite-devel gdbm-devel db4-devel libX11-devel gd-devel expat-devel  libmemcached-devel autoconf gcc gcc-c++ php-mcrypt  icu fontconfig libtool libtool-libs  perl gperftools libblkid-devel libudev-devel fuse-devel libedit-devel libatomic_ops-devel"
normal_packages="kernel-devel stress"
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
	yum_install_packages $toolkit_packages #>packages.log
	yum_install_packages $xtrabackup_packages #>>packages.log
	yum_install_packages $mysql_oracle #>>packages.log
	yum_install_packages $php_packages #>>packages.log

}
main
