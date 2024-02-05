FROM nvidia/cuda:12.1.0-cudnn8-devel-ubuntu22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Install Python 3.11
RUN apt-get update && apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:deadsnakes/ppa
RUN apt-get update && apt-get install -y python3.11 python3-pip

# Install necessary system dependencies
RUN apt-get install -y \
    build-essential \
    cmake \
    libopenblas-dev

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