FROM nvidia/cuda:12.1.0-cudnn8-devel-ubuntu22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    wget \
    libffi-dev \
    libgdbm-dev \
    libc6-dev \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    libncurses5-dev \
    libncursesw5-dev \
    xz-utils \
    tk-dev \
    liblzma-dev \
    python-openssl

# Download and install Python 3.11
WORKDIR /tmp
RUN wget https://www.python.org/ftp/python/3.11.0/Python-3.11.0.tgz
RUN tar -xvf Python-3.11.0.tgz
WORKDIR /tmp/Python-3.11.0
RUN ./configure --enable-optimizations
RUN make altinstall

# Install pip
RUN apt-get install -y python3-pip

# Install llama.cpp and MemGPT
RUN pip install llama-cpp-python memgpt

# Copy your shell script that uses llama.cpp to serve the model
COPY ./entrypoint.sh /app/entrypoint.sh

# Set the working directory
WORKDIR /app

# Make your shell script executable
RUN chmod +x /app/entrypoint.sh

# Run your script when the Docker container is started
ENTRYPOINT ["/app/entrypoint.sh"]