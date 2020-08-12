FROM ubuntu:18.04
LABEL maintainer="Pieter Compen <info@compen.net>"
LABEL Description="Image for building, debugging and documenting arm-embedded projects"
WORKDIR /work

ADD . /work

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
    bzip2 \
    curl \
    jq \
    wget && \
  apt-get clean
