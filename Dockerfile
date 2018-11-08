FROM ubuntu:16.04

# Commands for OpenCV-installation from this tutorial:
#  http://breakthrough.github.io/Installing-OpenCV/#installing-on-linux-compiling-from-source

# Installing default tools
RUN apt-get update \
    && apt-get install -y wget unzip python-setuptools

# Installing build dependencies
RUN apt-get install -y cmake build-essential pkg-config libgtk2.0-dev libtbb-dev python-dev python-numpy python-scipy libjasper-dev libjpeg-dev libpng-dev libtiff-dev libavcodec-dev libavutil-dev libavformat-dev libswscale-dev libdc1394-22-dev libv4l-dev

# Download OpenCV
WORKDIR /tmp
RUN wget https://github.com/opencv/opencv/archive/3.3.1.zip -qO /tmp/opencv.zip \
    && unzip -q /tmp/opencv.zip
RUN mkdir /tmp/opencv-3.3.1/build
WORKDIR /tmp/opencv-3.3.1/build

# Build and install OpenCV
RUN cmake -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=/usr/local ..
RUN make \
    && make install

# Specify a particular PySceneDetect release (e.g., '0.5') or leave blank for
# the latest version
ARG SCENEDETECT_VERSION=""

# Install PySceneDetect
RUN apt-get install -y python-pip && \
    if [ "$SCENEDETECT_VERSION" = "" ]; then \
      pip install scenedetect; \
    else \
      pip install scenedetect=="$SCENEDETECT_VERSION"; \
    fi

# Install MKVToolNix. Before we have to install apt-https support and add sources
RUN apt-get install -y apt-transport-https \
    && wget -q -O - https://mkvtoolnix.download/gpg-pub-moritzbunkus.txt | apt-key add - \
    && echo "deb https://mkvtoolnix.download/ubuntu/xenial/ ./" >> /etc/apt/sources.list \
    && echo "deb-src https://mkvtoolnix.download/ubuntu/xenial/ ./" >> /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -y mkvtoolnix

# Cleanup
RUN rm -rf /tmp/*
WORKDIR /tmp

ENTRYPOINT ["scenedetect"]
