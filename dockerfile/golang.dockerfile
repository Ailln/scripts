# 第一阶段：构建 Go 应用
FROM golang:1.22.10-alpine3.21 AS builder

# 设置工作目录
WORKDIR /workspace

# 复制 Go 模块文件并下载依赖
COPY go.mod go.sum ./
RUN go mod download

# 复制源代码
COPY . .

# 编译可执行文件（静态编译，优化体积）
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o app .

# 第二阶段：创建运行环境
FROM alpine:3.21.3

# 设置时区（可选）
RUN apk add --no-cache tzdata \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# 设置工作目录
WORKDIR /workspace/

# 复制构建好的可执行文件
COPY --from=builder /workspace/app .

# 运行应用
CMD ["./app"]

# 构建镜像命令
# docker build -t golang-demo:1.0.0 \
#   -f ./golang.dockerfile .

# 运行容器命令
# docker run -it --name golang-demo \
#   -p 8000:8000 golang-demo:1.0.0