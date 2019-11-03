## grpcurl

```basj
yum install epel-release
yum install -y golang

go get github.com/fullstorydev/grpcurl
go install github.com/fullstorydev/grpcurl/cmd/grpcurl
cd $GOPATH/go/bin
cp grpcurl /bin/
```