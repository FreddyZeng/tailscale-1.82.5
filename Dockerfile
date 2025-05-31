# ————————————————————————————
FROM golang:1.24-bullseye AS build-env

# 设置工作目录
WORKDIR /go/src/tailscale

# 1) 先复制 go.mod、go.sum 并下载依赖，这样后续修改源代码才不会每次都重拉依赖
COPY go.mod go.sum ./
RUN go mod download

# 2) 再把其余源码复制进来
COPY . .

ENV CGO_ENABLED=0

RUN go build -v -x -o /usr/local/bin/tailscale ./cmd/tailscale
RUN go build -v -x -o /usr/local/bin/tailscaled ./cmd/tailscaled
