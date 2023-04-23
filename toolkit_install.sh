#!/bin/bash

toolkit_install() {
  local toolkit_version="$1"
  local toolkit_url="https://downloads.percona.com/downloads/percona-toolkit/${toolkit_version}/binary/tarball/percona-toolkit-${toolkit_version}_x86_64.tar.gz"
  local toolkit_archive="percona-toolkit-${toolkit_version}_x86_64.tar.gz"
  local toolkit_dir="/usr/local/percona-toolkit-${toolkit_version}"
  
  if [ -d "${toolkit_dir}/bin" ]; then
    echo "percona-toolkit-${toolkit_version} is already installed."
  else
    wget "${toolkit_url}"
    tar -xzf "${toolkit_archive}"
    cd percona-toolkit-${toolkit_version}
    perl Makefile.PL
    make
    make test
    make install    
    #mv "percona-toolkit-${toolkit_version}" "${toolkit_dir}"
    
    echo "export PATH=\"${toolkit_dir}/bin:\$PATH\"" >> /etc/profile
    source /etc/profile
    pt-summary --version
    echo "percona-toolkit-${toolkit_version} is now installed."
  fi
}

toolkit_install "3.5.2"

