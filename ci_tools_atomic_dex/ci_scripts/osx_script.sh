#!/bin/bash

# Workaround for https://github.com/actions/setup-python/issues/577

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
            gnu-getopt

brew unlink python@3.12
brew install llvm
brew link --overwrite python@3.12

pip3 install yq
export CC=clang
export CXX=clang++
export MACOSX_DEPLOYMENT_TARGET=15

git clone https://github.com/KomodoPlatform/libwally-core.git --recurse-submodules
cd libwally-core
./tools/autogen.sh
./configure --disable-shared
sudo make -j3 install
cd ..

# get SDKs
git clone https://github.com/KomodoPlatform/MacOSX-SDKs $HOME/sdk
