
ntpdate_start(){
  sed -i -e '/^server/s/^/#/' -e '1a server ntp.aliyun.com iburst' /etc/chrony.conf
  systemctl restart chronyd.service
  systemctl enable chronyd.service

}

main(){
ntpdate_start

}
main
