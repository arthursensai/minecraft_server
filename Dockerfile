FROM ubuntu:20.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

# Create minecraft directory
WORKDIR /minecraft

# Download Bedrock Server
RUN wget https://minecraft.azureedge.net/bin-linux/bedrock-server-1.20.51.01.zip \
    && unzip bedrock-server-1.20.51.01.zip \
    && rm bedrock-server-1.20.51.01.zip

# Expose Minecraft port
EXPOSE 19132/udp

# Start the server
CMD ["./bedrock_server"]