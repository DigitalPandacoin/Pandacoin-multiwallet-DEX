#!/bin/bash

brew update
brew install autoconf \
            automake \
            pkgconfig \
            wget \
            nim \
            ninja \
            gnu-sed \
            coreutils \
            libtool \
            gnu-getopt \
            llvm

pip3 install yq
export CC=clang
export CXX=clang++
export MACOSX_DEPLOYMENT_TARGET=15.5

git clone https://github.com/ElementsProject/libwally-core --recurse-submodules -b release_0.9.2
cd libwally-core
./tools/autogen.sh
./configure --disable-shared
sudo make -j3 install
cd ..

# get SDKs
git clone https://github.com/phracker/MacOSX-SDKs $HOME/sdk
