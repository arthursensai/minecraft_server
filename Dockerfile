FROM ubuntu:20.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    libssl-dev

# Create minecraft directory
WORKDIR /minecraft

# Download Bedrock Server (use latest version)
RUN wget https://minecraft.azureedge.net/bin-linux/bedrock-server-1.20.51.01.zip \
    && unzip bedrock-server-1.20.51.01.zip \
    && rm bedrock-server-1.20.51.01.zip

# Expose Minecraft Bedrock port
EXPOSE 19132/udp

# Start the server
CMD ["./bedrock_server"]