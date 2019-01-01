FROM jjanzic/docker-python3-opencv:opencv-3.4.1

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
    && apt-get update \
    && apt-get install -y mkvtoolnix
	
RUN apt-get install -y ffmpeg

# Cleanup
RUN rm -rf /tmp/*
WORKDIR /tmp

ENTRYPOINT ["scenedetect"]
