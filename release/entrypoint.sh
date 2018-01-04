#!/bin/bash
GARLICOIND=/garlicoin/src/garlicoind

FORCE=0

while getopts "f" opt; do
    case $opt in
        f) FORCE=1
    esac
done

if [ ! -f $GARLICOIND ] || [ $FORCE -eq 1 ] || [ $FORCE_BUILD -eq 1 ]; then
    cd /garlicoin                    \
        && ./autogen.sh              \
        && ./configure --without-gui \
        && make                      \
        && make install
fi

bash -c "${GARLICOIND}"