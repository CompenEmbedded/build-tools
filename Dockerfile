FROM ubuntu:24.04

ENV DEBIAN_FRONTEND noninteractive
ENV DEBIAN_FRONTEND teletype
ENV TZ=Europe/Amsterdam

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && \
  apt-get upgrade -y && \
  apt-get install -y \
    build-essential \
    doxygen \
    git \
    openssh-client \
    gcc-arm-none-eabi \
    cmake \
    cmake-data \
    bzip2 \
    curl \
    jq \
    wget \
    python3-dev \
    python3-pip \
    ninja-build \
    cpplint \
    gcovr \
    lcov && \
  apt-get clean

RUN apt-get install -y openocd
RUN pip3 install telnetlib3 --break-system-packages
RUN pip3 install pysourcegen --break-system-packages

RUN apt -y install gdb-multiarch
RUN apt -y install dos2unix
RUN apt -y install xxd

RUN wget https://github.com/plantuml/plantuml/releases/download/v1.2024.6/plantuml-asl-1.2024.6.jar && mv plantuml-asl-1.2024.6.jar /usr/share/plantuml.jar
RUN apt -y install default-jre
RUN git clone https://github.com/jothepro/doxygen-awesome-css.git && cd doxygen-awesome-css && git checkout v2.3.3 && make install
RUN apt -y install graphviz
RUN apt -y install clang-format
RUN apt -y install qtbase5-dev qt5-qmake libqt5charts5-dev
