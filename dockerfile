# Use the official Ubuntu as a base image
FROM ubuntu:latest

# Set up environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Install required packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    wget 


# Download and install CUDA keyring
RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.1-1_all.deb \
    && dpkg -i cuda-keyring_1.1-1_all.deb

# Install CUDA Toolkit 12.4
RUN apt-get update && \
    apt-get -y install cuda-toolkit-12-4 

RUN  apt-get -y install libcudnn8-dev 

# Install TensorFlow GPU
RUN pip install tensorflow
RUN pip install  jupyter

# Set up a working directory
WORKDIR /workspace

# Copy your TensorFlow code into the container
COPY ./workspace /workspace

# Expose the port for Jupyter Notebook
EXPOSE 8888

# Start Jupyter Notebook server as the default command
CMD ["jupyter", "notebook", "--ip='*'", "--port=8888", "--no-browser", "--allow-root"]
