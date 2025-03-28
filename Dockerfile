# Use the official Ubuntu 20.04 image
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

# Download Bedrock Edition Server directly from Mojang's official source
RUN wget https://minecraft.azureedge.net/bin-linux/bedrock-server-1.20.30.03.tar.gz \
    && tar -xvzf bedrock-server-1.20.30.03.tar.gz \
    && rm bedrock-server-1.20.30.03.tar.gz \
    && touch eula.txt \
    && echo "eula=true" > eula.txt

# Expose Minecraft Bedrock Edition port
EXPOSE 19132/udp

# Set up entrypoint script
RUN echo '#!/bin/bash\n\
./bedrock_server' > /start.sh \
    && chmod +x /start.sh

# Start the server
CMD ["/start.sh"]
