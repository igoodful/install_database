#!/bin/bash
node_version='12.16.3'
node_package_dir="node-v${node_version}-linux-x64"
node_package_targz="${node_package_dir}.tar.gz"
function install(){
wget https://nodejs.org/dist/v${node_version}/${node_package_targz}
tar -xzvf ${node_package_targz}
ln -s   /usr/bin/node
ln -s   /usr/bin/npm



}

