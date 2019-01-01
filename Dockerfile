FROM jjanzic/docker-python3-opencv:opencv-3.4.1

# Download PySceneDetect
WORKDIR /tmp
RUN wget https://github.com/Breakthrough/PySceneDetect/archive/v0.5.zip -qO /tmp/pyscenedetect.zip \
    && unzip -q /tmp/pyscenedetect.zip

# Install PySceneDetect
WORKDIR /tmp/PySceneDetect-0.5
RUN python setup.py install

# Install MKVToolNix. Before we have to install apt-https support and add sources
RUN apt-get install -y apt-transport-https \
    && wget -q -O - https://mkvtoolnix.download/gpg-pub-moritzbunkus.txt | apt-key add - \
    && echo "deb https://mkvtoolnix.download/ubuntu/ xenial main" >> /etc/apt/sources.list \
    && echo "deb-src https://mkvtoolnix.download/ubuntu/ xenial main" >> /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -y mkvtoolnix
	
RUN apt-get install -y ffmpeg

# Cleanup
RUN rm -rf /tmp/*
WORKDIR /tmp

ENTRYPOINT ["scenedetect"]
