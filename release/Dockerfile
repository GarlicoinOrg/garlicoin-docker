FROM debian:stable-slim

RUN echo "deb http://archive.debian.org/debian/ squeeze main contrib non-free" >> /etc/apt/sources.list \
    echo "deb-src http://archive.debian.org/debian/ squeeze main contrib non-free" >> /etc/apt/sources.list
RUN useradd -r garlicoin    \
    && mkdir /garlicoin     \
    && apt-get update -y    \
    && apt-get install -y   \
        --allow-unauthenticated \
        git                 \
        build-essential     \
        libtool             \
        autotools-dev       \
        automake            \
        pkg-config          \
        libssl-dev          \
        libevent-dev        \
        bsdmainutils        \
        libboost-all-dev    \
        libdb4.8-dev        \
        libdb4.8++-dev      \
    && apt-get clean        \
    && git clone https://github.com/litecoin-project/litecoin.git /garlicoin

COPY ./entrypoint.sh /
