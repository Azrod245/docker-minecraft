# -----------------------------------------------------------------------------
# docker-minecraft
#
# Builds a basic docker image that can run a Minecraft server
# (http://minecraft.net/).
# -----------------------------------------------------------------------------

# Base image is the latest LTS version of Ubuntu
FROM ubuntu:22.04

LABEL org.opencontainers.image.source = "https://github.com/Azrod245/docker-minecraft" 

# Make sure we don't get notifications we can't answer during building.
ENV DEBIAN_FRONTEND noninteractive

# Download and install the required dependencies
RUN apt-get -y update && \
	apt-get -y install software-properties-common && \
	add-apt-repository universe && \
    apt-get -y install \
        curl \
        openjdk-21-jdk-headless

# Load in all of our config files.
ADD ./scripts/start /start

# Fix all permissions
RUN chmod +x /start

# 25565 is for minecraft
EXPOSE 25565

# /data contains static files and database
VOLUME ["/data"]

# /start runs it.
CMD ["/start"]
