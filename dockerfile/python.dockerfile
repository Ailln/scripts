# 使用 Python 3.11.11 的 Alpine Linux 3.21 基础镜像，体积小巧且安全
FROM python:3.11.11-alpine3.21

# 设置工作目录为 /app
WORKDIR /app

# 将当前目录下的所有文件复制到容器的工作目录中
COPY . .

# 安装 requirements.txt 中指定的 Python 依赖包
RUN pip install -r requirements.txt

# 暴露 8000 端口供外部访问
EXPOSE 8000

# 设置容器启动时执行的命令，运行 main.py 文件
CMD ["python", "main.py"]

# 构建镜像命令
# docker build -t python-demo:1.0.0 \
#   -f ./python.dockerfile .

# 运行容器命令
# docker run -it --name python-demo \
#   -p 8000:8000 python_demo:1.0.0
