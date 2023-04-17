#!/bin/bash

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


yum_install_packages $*
