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

# Download Bedrock Server directly from official source
RUN wget https://piston-data.mojang.com/v1/objects/ead5059acb994e5acf0b14a30ba5536f2303246c/server.jar \
    && mkdir -p /minecraft \
    && touch eula.txt \
    && echo "eula=true" > eula.txt

# Expose Minecraft port
EXPOSE 19132/udp

# Set up entrypoint script
RUN echo '#!/bin/bash\n\
java -Xmx1024M -Xms1024M -jar server.jar nogui' > /start.sh \
    && chmod +x /start.sh

# Start the server
CMD ["/start.sh"]