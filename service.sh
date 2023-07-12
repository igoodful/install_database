
ntpdate_start(){
  systemctl enable chronyd.service
  systemctl start chronyd.service

}

main(){
ntpdate_start

}
main
