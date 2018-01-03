FROM debian:stable-slim

RUN useradd -r garlicoin    \
    && mkdir /garlicoin     \
    && apt-get update -y    \
    && apt-get install -y   \
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
    && apt-get clean        \
    && git clone https://github.com/litecoin-project/litecoin.git /garlicoin

COPY ./entrypoint.sh /
