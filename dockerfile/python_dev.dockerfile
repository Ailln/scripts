# Use Python base image with Debian Bookworm
FROM python:3.11.10-bookworm

# Set environment variables
ENV PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    PIP_DEFAULT_TIMEOUT=100

# Install common tools and dependencies
RUN apt-get update && apt-get install -y \
    git vim tmux \
    build-essential \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Configure pip to use TUNA mirror
RUN mkdir -p /root/.pip && echo "[global]\nindex-url = https://pypi.tuna.tsinghua.edu.cn/simple\n" > /root/.pip/pip.conf

# Set up a workspace directory
WORKDIR /workspace

# Install pipenv, virtualenv, and other common Python tools
RUN pip install pandas numpy

# Expose common development port (optional)
EXPOSE 8000

# Default command
CMD ["bash"]

# build
# docker build -t python_3_11-dev:1.0.0 \
#   -f ./python_dev.dockerfile .
# run
# docker run -it --name python-dev \
#   -v $PWD:/workspace/ -p 8000:8000 \
#   python_3_11-dev:1.0.0
