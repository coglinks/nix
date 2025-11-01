FROM golang:1.21
MAINTAINER GitHub, Inc.

WORKDIR /go/src/github.com/git-lfs/lfs-test-server

# Environment variables for LFS
ENV \
  LFS_LISTEN="tcp://:9999" \
  LFS_HOST="127.0.0.1:9999" \
  LFS_CONTENTPATH="content" \
  LFS_ADMINUSER="coglinks" \
  LFS_ADMINPASS="EoF7zovfZrQf7UtbVa8ARL" \
  LFS_CERT="mine.crt" \
  LFS_KEY="mine.key" \
  LFS_SCHEME="http"

COPY . .

RUN go build

EXPOSE 9999

CMD /go/src/github.com/git-lfs/lfs-test-server/lfs-test-server
