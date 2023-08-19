#!/bin/bash
node_version='17.8.0'
node_version='17.8.0'
node_package_dir="node-v${node_version}-linux-x64"
node_package_targz="${node_package_dir}.tar.gz"
install_dir="/data/node-${node_version}"
mkdir -p $install_dir

function install() {
	wget https://nodejs.org/dist/v${node_version}/${node_package_targz}
	tar -xzvf ${node_package_targz}
	mv node-v${node_version}-linux-x64/* ${install_dir}/
	if [ -f ${install_dir}/bin/npm ]; then
		rm -rf /usr/bin/node
		rm -rf /usr/bin/npx
		rm -rf /usr/bin/npm
		ln -s ${install_dir}/bin/node /usr/bin/node
		ln -s ${install_dir}/bin/npm /usr/bin/npm
		ln -s ${install_dir}/bin/npx /usr/bin/npx
		echo "install ok"
	else
		echo "install fail"
		exit 1
	fi

}

install
