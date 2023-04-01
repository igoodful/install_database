#!/bin/bash
soft_path='/data/app/tmp'
linux_user='oracle'
linux_group='oinstall'
linux_password='oracle'
linux_hostname=$(hostname)
install_time=$(date  '+%Y%m%d%H%M%S')
linux_user_bash_profile="/home/${linux_user}/.bash_profile"
oracle_base_dir='/data/app/oracle'
oracle_base_dir_sed=$(echo ${oracle_base_dir} | sed 's/\//\\\//g')

oracle_home_dir="${oracle_base_dir}/product/11.2.0/dbhome_1"
oracle_home_dir_sed=$(echo ${oracle_home_dir} | sed 's/\//\\\//g')

oracle_inventory_dir='/data/app/oracle_inventory'
oracle_inventory_dir_sed=$(echo ${oracle_inventory_dir} | sed 's/\//\\\//g')

db_name='orcl'
oracle_data_dir="${oracle_base_dir}/${db_name}"

function is_installed(){
if [ -e "${oracle_base_dir}" ]
then
echo "${oracle_base_dir}  exists"
exit 1
else
echo "starting ..."
# 
rm -rf /etc/oraInst.loc
mkdir -p $oracle_base_dir
mkdir -p $oracle_home_dir
mkdir -p $oracle_inventory_dir
fi
}


function user_add(){
# create user and group
groupadd -g 501 oinstall
groupadd -g 502 dba
groupadd -g 503 oper
useradd -u 501 -g oinstall -G oracle
echo ${linux_user}:${linux_password} | chpasswd
}

function bash_profile_update(){
sed -i '/.*ORACLE_BASE.*/d'  $linux_user_bash_profile
sed -i '/.*ORACLE_HOME.*/d' $linux_user_bash_profile
sed -i '/.*ORACLE_SID.*/d' $linux_user_bash_profile
echo "export ORACLE_BASE=${oracle_base_dir}" >> $linux_user_bash_profile
echo "export ORACLE_HOME=${oracle_home_dir}" >> $linux_user_bash_profile
echo "export ORACLE_SID=${db_name}" >> $linux_user_bash_profile
echo "export PATH=\$PATH:\$ORACLE_HOME/bin" >> $linux_user_bash_profile

}

function init_dep(){
yum -y install perl-Data-Dumper lvm2* unzip rlwrap screen binutils binutils-devel compat-db control-center control-center-devel compat-libstdc++-* elfutils-libelf elfutils-libelf-devel elfutils-libelf-devel-static expat expat-devel gcc gcc-c++ glibc libaio libaio-devel libgcc libstdc++ libstdc++-devel libXp libXp-devel make openmotif openmotif-devel ksh unixODBC unixODBC-devel mdadm readline*


}

function limits_conf_update(){
cp /etc/security/limits.conf  /etc/security/limits.conf.${install_time}
cat > /etc/security/limits.conf << EOF
${linux_user} soft nproc 16384
${linux_user} hard nproc 16384
${linux_user} soft nofile 65536
${linux_user} hard nofile 65536
${linux_user} soft stack 1024000
${linux_user} hard stack 1024000
EOF

}

function sysctl_conf_uodate(){
# 配置系统内核,尤其是共享内存段的大小，设置为物理内存的80%,如果非 Oracle 专用服务器，请酌情修改共享内存段大小
TTM=`free -b|grep Mem|awk '{print $2}'`
SHM=$(($TTM*4/5))
SHMMALL=$(($SHM/4096))
cp /etc/sysctl.conf /etc/sysctl.conf.${install_time}
cat > /etc/sysctl.conf << EOF
#oracle
kernel.sysrq = 0
kernel.msgmnb = 65536
kernel.shmall = $SHMMALL
fs.file-max = 6815744
kernel.msgmni = 2878
kernel.msgmax = 8192
kernel.msgmnb = 65536
kernel.sem = 250 32000 100 142
kernel.shmmni = 4096
kernel.shmmax = $SHM
kernel.sysrq = 0
net.core.wmem_default = 262144
net.core.rmem_default = 262144
net.core.rmem_max = 4194304
net.core.wmem_max = 1048576
fs.aio-max-nr = 3145728
net.ipv4.ip_local_port_range = 9000 65500
vm.swappiness=10
EOF
sysctl -p

}

function prspfile_update(){
prspfile=$(find ${soft_path} -name db_install.rsp)
cp $prspfile  ${prspfile}.${install_time}
sed -i "s/oracle.install.option=.*/oracle.install.option=INSTALL_DB_SWONLY/" $prspfile
sed -i "s/ORACLE_HOSTNAME=.*/ORACLE_HOSTNAME=${linux_hostname}/" $prspfile
sed -i "s/UNIX_GROUP_NAME=.*/UNIX_GROUP_NAME=oinstall/" $prspfile
sed -i "s/INVENTORY_LOCATION=.*/INVENTORY_LOCATION=${oracle_inventory_dir_sed}/" $prspfile
sed -i "s/SELECTED_LANGUAGES=en.*/SELECTED_LANGUAGES=en,zh_TW,zh_CN/" $prspfile
sed -i "s/ORACLE_HOME=.*/ORACLE_HOME=${oracle_home_dir_sed}/" $prspfile
sed -i "s/ORACLE_BASE=.*/ORACLE_BASE=${oracle_base_dir_sed}/" $prspfile
sed -i 's/oracle.install.db.InstallEdition=.*/oracle.install.db.InstallEdition=EE/' $prspfile
sed -i 's/oracle.install.db.DBA_GROUP=.*/oracle.install.db.DBA_GROUP=oinstall/' $prspfile
sed -i 's/oracle.install.db.OPER_GROUP=.*/oracle.install.db.OPER_GROUP=oinstall/' $prspfile
sed -i 's/oracle.install.db.CLUSTER_NODES=.*/#oracle.install.db.CLUSTER_NODES=/' $prspfile
sed -i 's/SECURITY_UPDATES_VIA_MYORACLESUPPORT=.*/SECURITY_UPDATES_VIA_MYORACLESUPPORT=false/' $prspfile
sed -i 's/DECLINE_SECURITY_UPDATES=.*/DECLINE_SECURITY_UPDATES=true/' $prspfile
sed -i 's/oracle.installer.autoupdates.option=.*/oracle.installer.autoupdates.option=SKIP_UPDATES/' $prspfile

}


function oracle_install(){
chown -R ${linux_user}:${linux_group} $oracle_base_dir
chown -R ${linux_user}:${linux_group} $oracle_inventory_dir
chmod 755 $oracle_base_dir
chmod 755 $oracle_inventory_dir
chmod 755 $soft_path
prspfile=$(find ${soft_path} -name db_install.rsp)
installer=$(find ${soft_path} -name runInstaller)
su - ${linux_user} >> oracle_install.log.${install_time} <<EOF
$installer -silent -responseFile $prspfile -ignoreSysPrereqs -ignorePrereq
EOF
echo "sleeping 300"
sleep 300
if [ -f "${oracle_home_dir}/root.sh"  ]
then
sh ${oracle_inventory_dir}/orainstRoot.sh
sh ${oracle_home_dir}/root.sh
chown -R ${linux_user}:${linux_group} $oracle_base_dir
chown -R ${linux_user}:${linux_group} $oracle_inventory_dir
chmod 755 $oracle_base_dir
chmod 755 $oracle_inventory_dir
chmod 755 $soft_dir
else
echo "function oracle_install not seccess "
exit 2
fi
}

function netca_rsp_update(){
lrspfile=$(find ${soft_path} -name netca.rsp)
su - ${linux_user} > net.log <<EOF
netca -silent -responseFile $lrspfile
EOF
t=`echo $?`
if [ $t -eq 0 ]
then
echo "netca is right"
else
echo "netca is wrong"
exit
fi
}

function dbca_rsp_update(){
drspfile=$(find ${soft_path} -name dbca.rsp)
echo $drspfile
sed -i 's/GDBNAME = "orcl11g.us.oracle.com".*/GDBNAME = "'${db_name}'"/g' $drspfile
sed -i 's/SID = "orcl11g".*/SID = "'${db_name}'"/g' $drspfile
sed -i 's/#SYSPASSWORD = "password".*/SYSPASSWORD = "oracle"/g' $drspfile
sed -i 's/#SYSTEMPASSWORD = "password".*/SYSTEMPASSWORD = "oracle"/g' $drspfile
sed -i 's/#EMCONFIGURATION = "NONE"/EMCONFIGURATION = "NONE"/g' $drspfile
sed -i 's/#SYSMANPASSWORD = "password".*/SYSMANPASSWORD = "oracle"/g' $drspfile
sed -i 's/#DBSNMPPASSWORD = "password".*/DBSNMPPASSWORD = "oracle"/g' $drspfile
sed -i 's/#CHARACTERSET = "US7ASCII".*/CHARACTERSET = "ZHS16GBK"/g' $drspfile
sed -i 's/#MEMORYPERCENTAGE = "40".*/MEMORYPERCENTAGE = "70"/g' $drspfile
# 模板文件中修改为库名为想要的库名
mrspfile=$(find ${soft_path} -name General_Purpose.dbc)
echo $mrspfile
sed -i 's#{ORACLE_BASE}/oradata/{DB_UNIQUE_NAME}#'${oracle_data_dir}'/oradata#g' $mrspfile

red=$(cat $mrspfile|grep -w "${oracle_data_dir}/oradata"|wc -l)
if [ $red -eq 10 ]
then
echo "Sed dbca.rsp & General_Purpose.dbc is OK"
else
echo "Sed dbca.rsp & General_Purpose.dbc is Wrong"
fi
}

function init_oracle(){
cat oracle_install.log.${install_time} |grep 'Successfully' 
echo "================="
if [ $? == 0  ]
then
echo "Successfully"
else
echo " error"
exit 3
fi

echo "starting init_oracle ..."
su - ${linux_user} << EOF
sqlplus / as sysdba
alter system set processes=5000 scope=spfile;
alter system set session_cached_cursors=1000 scope=spfile;
alter system set open_cursors=1000 scope=spfile;
alter system set "_optimizer_null_aware_antijoin"=false sid ='*' scope=spfile;
alter system set "_b_tree_bitmap_plans"=false sid='*' scope=spfile;
alter system set "_optimizer_adaptive_cursor_sharing"=false sid='*' scope=spfile;
alter system set "_optimizer_extended_cursor_sharing"=none sid='*' scope=spfile;
alter system set "_optimizer_extended_cursor_sharing_rel"=none sid='*' scope=spfile;
alter system set "_optimizer_use_feedback"=false sid ='*' scope=spfile;
alter system set deferred_segment_creation=false sid='*' scope=spfile;
alter system set event='28401 trace name context forever,level 1','10949 trace name context forever,level 1' sid='*' scope=spfile;
alter system set "_px_use_large_pool"=true sid ='*' scope=spfile;
alter system set "_undo_autotune"=false sid='*' scope=spfile;
alter system set audit_trail=none sid='*' scope=spfile;
alter system set "_partition_large_extents"=false sid='*' scope=spfile;
alter system set "_index_partition_large_extents"=false sid='*' scope=spfile;
alter system set enable_ddl_logging=true sid='*' scope=spfile;
alter system set log_archive_dest_1='location=${db_data}/archivelog';
alter system set log_archive_format='%t_%s_%r.arc' scope=spfile;
create pfile from spfile;
Shutdown immediate
startup mount
alter database archivelog;
alter database open;
exit;
EOF
}

function main(){
is_installed
init_dep
user_add
limits_conf_update
sysctl_conf_uodate
bash_profile_update
prspfile_update
oracle_install
netca_rsp_update
dbca_rsp_update
init_oracle
}
main


































