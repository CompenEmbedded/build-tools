FROM ubuntu:20.04
LABEL maintainer="Pieter Compen <info@compen.net>"
LABEL Description="Image for building, debugging, testing and documenting arm-embedded projects"

WORKDIR /work

ENV DEBIAN_FRONTEND noninteractive
ENV DEBIAN_FRONTEND teletype
ENV DOTNET_CLI_TELEMETRY_OPTOUT=1
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
    texlive-full \
    graphviz \
    ninja-build \
    libturbojpeg0-dev \
    libsdl2-dev \
    libglew-dev \
    libsdl2-image-dev \
    libglm-dev \
    lcov && \
  apt-get clean

# Download .NET
RUN wget https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && yes | dpkg -i packages-microsoft-prod.deb

RUN apt-get update && \
  apt-get install -y apt-transport-https && \
  apt-get update && \
  apt-get install -y dotnet-sdk-5.0 && \
  apt-get clean

# Install CppLint
RUN pip3 install cpplint

# Install Gcovr
RUN pip3 install gcovr

# Install Catch2
RUN git clone --depth 1 --branch v2.13.0 https://github.com/catchorg/Catch2.git && \
    cd Catch2 && \
    cmake -Bbuild -H. -DBUILD_TESTING=OFF && \
    cmake --build build/ --target install 
