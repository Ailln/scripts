# 使用基于 Debian Bookworm 的 Go 基础镜像
FROM golang:1.22.10-bookworm

# 设置环境变量
ENV AIR_VERSION=1.61.7 \
    GOPROXY=https://goproxy.cn,direct \
    GO111MODULE=on \
    CGO_ENABLED=0

# 安装常用工具和依赖
RUN apt-get update && apt-get install -y \
    git vim tmux \
    build-essential \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# 安装 Air 用于热重载（兼容 Linux 和 Mac）
RUN ARCH=$(uname -m) && OS=$(uname -s | tr '[:upper:]' '[:lower:]') && \
    if [ "$ARCH" = "aarch64" ]; then ARCH="arm64"; fi && \
    if [ "$ARCH" = "x86_64" ]; then ARCH="amd64"; fi && \
    curl -sSL "https://github.com/air-verse/air/releases/download/v${AIR_VERSION}/air_${AIR_VERSION}_${OS}_${ARCH}" -o /usr/local/bin/air && \
    chmod +x /usr/local/bin/air && \
    # 验证 Air 安装
    air -v

# 设置工作目录
WORKDIR /workspace

# 设置 GOPATH 和 PATH
ENV GOPATH=/workspace/go \
    PATH=/workspace/go/bin:/usr/local/go/bin:$PATH

# 暴露常用开发端口（可选）
EXPOSE 8000

# 默认命令
CMD ["bash"]

# 构建镜像命令
# docker build -t golang_1_22-air_1_43-dev:1.0.0 \
#   -f ./golang_dev.dockerfile .

# 运行容器命令
# docker run -it --name golang-dev \
#   -v $PWD:/workspace/ -p 8000:8000 \
#   golang_1_22-air_1_43-dev:1.0.0