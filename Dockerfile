FROM node:12-slim

MAINTAINER Jan Merkel

ENV DEBIAN_FRONTEND noninteractive

# Install prerequisites (as listed in iobroker installer.sh)
RUN apt-get update && apt-get install -y \
        acl \
        apt-utils \
        build-essential \
        curl \
        git \
        gnupg2 \
        gosu \
        jq \
        libavahi-compat-libdnssd-dev \
        libcap2-bin \
        libpam0g-dev \
        libudev-dev \
        locales \
        pkg-config \
        procps \
        python \
        python-dev \
        sudo \
        udev \
        unzip \
        wget \
    && rm -rf /var/lib/apt/lists/*

# Generating locales
RUN sed -i 's/^# *\(de_DE.UTF-8\)/\1/' /etc/locale.gen \
	&& sed -i 's/^# *\(en_US.UTF-8\)/\1/' /etc/locale.gen \
	&& locale-gen

# Create scripts directorys and copy scripts
RUN mkdir -p /opt/scripts/ \
    && chmod 777 /opt/scripts/
WORKDIR /opt/scripts/
COPY scripts/iobroker_startup.sh iobroker_startup.sh
COPY scripts/setup_avahi.sh setup_avahi.sh
COPY scripts/setup_packages.sh setup_packages.sh
RUN chmod +x iobroker_startup.sh \
    && chmod +x setup_avahi.sh \
    && chmod +x setup_packages.sh

# Install ioBroker
WORKDIR /
RUN apt-get update \
    && curl -sL https://iobroker.net/install.sh | bash - \
    && echo $(hostname) > /opt/iobroker/.install_host \
    && echo $(hostname) > /opt/.firstrun \
    && rm -rf /var/lib/apt/lists/*

# Install node-gyp
WORKDIR /opt/iobroker/
RUN npm install -g node-gyp

# Backup initial ioBroker and userscript folder
RUN tar -cf /opt/initial_iobroker.tar /opt/iobroker

# Setting up iobroker-user (shell and home directory)
RUN chsh -s /bin/bash iobroker \
    && usermod --home /opt/iobroker iobroker

# Setting up ENVs
ENV DEBIAN_FRONTEND="teletype" \
	LANG="de_DE.UTF-8" \
	LANGUAGE="de_DE:de" \
	LC_ALL="de_DE.UTF-8" \
	TZ="Europe/Berlin" \
	PACKAGES="nano" \
        SETGID=1000 \
        SETUID=1000 \
	AVAHI="false"

# Setting up EXPOSE for Admin
EXPOSE 8081/tcp	
	
# Run startup-script
ENTRYPOINT ["/bin/bash", "-c", "/opt/scripts/iobroker_startup.sh"]
