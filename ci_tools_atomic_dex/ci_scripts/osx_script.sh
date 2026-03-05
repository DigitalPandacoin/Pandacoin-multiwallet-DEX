#!/bin/bash

export CC=clang
export CXX=clang++
export MACOSX_DEPLOYMENT_TARGET=11.3

git clone https://github.com/ElementsProject/libwally-core --recurse-submodules -b release_0.9.2
cd libwally-core
./tools/autogen.sh
./configure --disable-shared --disable-tests
sudo make -j3 install
cd ..

# get SDKs
git clone https://github.com/phracker/MacOSX-SDKs $HOME/sdk
