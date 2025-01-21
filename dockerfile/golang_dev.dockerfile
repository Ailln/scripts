# Use Golang base image with Debian Bookworm
FROM golang:1.22.10-bookworm

# Set environment variables
ENV AIR_VERSION=1.61.7 \
    GOPROXY=https://goproxy.cn,direct \
    GO111MODULE=on

# Install common tools and dependencies
RUN apt-get update && apt-get install -y \
    git vim tmux \
    build-essential \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install Air for live reload (compatible with Linux and Mac)
RUN ARCH=$(uname -m) && OS=$(uname -s | tr '[:upper:]' '[:lower:]') && \
    if [ "$ARCH" = "aarch64" ]; then ARCH="arm64"; fi && \
    curl -sSL "https://github.com/air-verse/air/releases/download/v${AIR_VERSION}/air_${AIR_VERSION}_${OS}_${ARCH}" -o /usr/local/bin/air && \
    chmod +x /usr/local/bin/air && \
    # Verify Air installation
    air -v

# Set up a workspace directory
WORKDIR /workspace

# Set GOPATH and PATH
ENV GOPATH=/workspace/go \
    PATH=/workspace/go/bin:/usr/local/go/bin:$PATH

# Expose common development port (optional)
EXPOSE 8000

# Default command
CMD ["bash"]

# build
# docker build -t golang_1_22-air_1_43-dev:1.0.0 \
#   -f ./golang_dev.dockerfile .
# run
# docker run -it --name golang-dev \
#   -v $PWD:/workspace/ -p 8000:8000 \
#   golang_1_22-air_1_43-dev:1.0.0