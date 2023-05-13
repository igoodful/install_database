#!/bin/bash
yum -y install go
go env -w GOPROXY=https://goproxy.cn,direct
go env -w GOSUMDB=off
go env -w GOSUMDB="sum.golang.google.cn"
