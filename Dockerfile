FROM ubuntu:24.04

ENV DEBIAN_FRONTEND noninteractive
ENV DEBIAN_FRONTEND teletype
ENV TZ=Europe/Amsterdam

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && \
  apt-get upgrade -y && \
  apt-get install -y \
    build-essential \
    libcmocka0 \
    libcmocka-dev \
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

# Install Catch2
RUN git clone --depth 1 --branch v3.6.0 https://github.com/catchorg/Catch2.git && \
    cd Catch2 && \
    cmake -Bbuild -H. -DBUILD_TESTING=OFF && \
    cmake --build build/ --target install 
