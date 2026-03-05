#!/bin/bash

export CC=clang
export CXX=clang++
export MACOSX_DEPLOYMENT_TARGET=11.3

# get SDK
curl -LJO https://github.com/phracker/MacOSX-SDKs/releases/download/11.3/MacOSX11.3.sdk.tar.xz
tar -xf MacOSX11.3.sdk.tar.xz -C $HOME/sdk

# build libwally
git clone https://github.com/ElementsProject/libwally-core --recurse-submodules -b release_0.9.2
cd libwally-core
./tools/autogen.sh
./configure --disable-shared --disable-tests
sudo make -j3 install
cd ..
