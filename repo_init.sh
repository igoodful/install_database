#!/bin/bash
mysql_oracle="bison m4 autoconf make cmake gcc gcc-c++  Perl ncurses  ncurses-devel libaio libaio-devel openssl openssl-devel bzip2 glibc glibc-headers gmp-devel mpfr-devel libmpc-devel"
toolkit_packages="perl-TermReadKey perl-ExtUtils-MakeMaker perl-CPAN  perl-DBI perl-DBD-MySQL perl-Time-HiRes perl-IO-Socket-SSL perl-Digest-MD5"
xtrabackup_packages="centos-release-scl scl-utils-build devtoolset-8-toolchain devtoolset-9-toolchain devtoolset-10-toolchain devtoolset-11-toolchain cmake cmake3 gcc gcc-c++ automake autoconf bison libtool vim-common python-sphinx libaio libaio-devel ncurses-devel libgcrypt-devel libev-devel libcurl-devel libgpg-error-devel libidn-devel perl-DBD-MySQL qpress"
function yum_install_packages() {
    # 将输入的软件包名称存储到数组中
    packages=("$@")

    installed=() # 存储已安装的软件包
    not_found=() # 存储不存在的软件包
    failed=()    # 存储安装失败的软件包

    for pkg in "${packages[@]}"
    do
        if yum list installed "$pkg" > /dev/null 2>&1; then
            installed+=("$pkg")
            echo "$pkg already installed"
        else
            if yum list available "$pkg" > /dev/null 2>&1; then
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
    echo "==========================================================================================================="    
    echo "Installed packages: ${installed[*]}"
    echo "Not found packages: ${not_found[*]}"
    echo "Failed packages: ${failed[*]}"
    echo "==========================================================================================================="    

    if [ ${#installed[@]} -eq ${#packages[@]} ]; then
        return 0
    else
        #return 1
        exit 1
    fi
}


function main(){
yum_install_packages $toolkit_packages
yum_install_packages $xtrabackup_packages
yum_install_packages $mysql_oracle

}
main

