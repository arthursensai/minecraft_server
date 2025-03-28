FROM ubuntu:20.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Create minecraft directory
WORKDIR /minecraft

# Download Bedrock Server using curl
RUN curl -L -o bedrock-server.zip https://github.com/PocketHost/minecraft-bedrock-server/releases/download/v1.20.51.01/bedrock-server.zip \
    && unzip bedrock-server.zip \
    && rm bedrock-server.zip

# Expose Minecraft Bedrock port
EXPOSE 19132/udp

# Set environment variables
ENV LD_LIBRARY_PATH=.

# Start the server
CMD ["./bedrock_server"]