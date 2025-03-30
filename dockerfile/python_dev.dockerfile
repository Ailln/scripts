# 使用基于 Debian Bookworm 的 Python 基础镜像
FROM python:3.11.10-bookworm

# 设置环境变量
ENV PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    PIP_DEFAULT_TIMEOUT=100

# 安装常用工具和依赖
RUN apt-get update && apt-get install -y \
    git vim tmux \
    build-essential \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# 配置 pip 使用清华镜像源
RUN mkdir -p /root/.pip && \
    echo "[global]\nindex-url = https://pypi.tuna.tsinghua.edu.cn/simple\n" > /root/.pip/pip.conf

# 设置工作目录
WORKDIR /workspace

# 安装 pandas、numpy 等常用 Python 工具
RUN pip install pandas numpy

# 暴露常用开发端口（可选）
EXPOSE 8000

# 默认命令
CMD ["bash"]

# 构建镜像命令
# docker build -t python_3_11-dev:1.0.0 \
#   -f ./python_dev.dockerfile .

# 运行容器命令
# docker run -it --name python-dev \
#   -v $PWD:/workspace/ -p 8000:8000 \
#   python_3_11-dev:1.0.0
