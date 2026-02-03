#!/bin/bash

sudo apt-get update

# base deps
sudo apt-get install build-essential \
                    libgl1-mesa-dev \
                    ninja-build \
                    curl \
                    wget \
                    zstd \
                    software-properties-common \
                    lsb-release \
                    libpulse-dev \
                    libtool \
                    autoconf \
                    unzip \
                    libssl-dev \
                    libxkbcommon-x11-0 \
                    libxcb-icccm4 \
                    libxcb-image0 \
                    libxcb1-dev \
                    libxcb-keysyms1-dev \
                    libxcb-render-util0-dev \
                    libxcb-xinerama0 \
                    libfuse2 \
                    git -y

# Qt
sudo apt-get install qtbase5-dev qtdeclarative5-dev qttools5-dev libqt5svg5-dev libqt5charts5-dev qtwebengine5-dev qtquickcontrols2-5-dev -y
sudo apt-get install qml-module-qtquick-controls qml-module-qtquick-controls2 qml-module-qtquick-dialogs qml-module-qtquick-extras qml-module-qtquick-layouts qml-module-qtquick-shapes qml-module-qt-labs-settings qml-module-qt-labs-platform qml-module-qtwebengine qml-module-qtcharts qml-module-qtgraphicaleffects -y
sudo apt-get install libxcursor-dev libxcomposite-dev libxdamage-dev libxrandr-dev libxtst-dev libxss-dev libdbus-1-dev libevent-dev libfontconfig1-dev libcap-dev libudev-dev libpci-dev libnss3-dev libasound2-dev libegl1-mesa-dev gperf bison nodejs -y

#sudo apt-get dist-upgrade -t jammy-backports -y

# get libwally
git clone https://github.com/ElementsProject/libwally-core --recurse-submodules -b release_0.9.2
cd libwally-core
./tools/autogen.sh
./configure --disable-shared
sudo make -j3 install
cd ..
