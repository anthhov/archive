#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset
set -o xtrace

GCC_VERSION=${GCC_VERSION:-9}

add-apt-repository ppa:ubuntu-toolchain-r/test --yes
DEBIAN_FRONTEND=noninteractive apt-get install --yes --no-install-recommends \
  gcc-$GCC_VERSION \
  g++-$GCC_VERSION \

ln -sf /usr/bin/gcc-$GCC_VERSION /usr/bin/gcc
ln -sf /usr/bin/g++-$GCC_VERSION /usr/bin/g++
ln -sf /usr/bin/gcc-ar-$GCC_VERSION /usr/bin/gcc-ar
ln -sf /usr/bin/gcc-nm-$GCC_VERSION /usr/bin/gcc-nm
ln -sf /usr/bin/gcc-ranlib-$GCC_VERSION /usr/bin/gcc-ranlib
ln -sf /usr/bin/gcov-$GCC_VERSION /usr/bin/gcov
ln -sf /usr/bin/gcov-dump-$GCC_VERSION /usr/bin/gcov-dump
ln -sf /usr/bin/gcov-tool-$GCC_VERSION /usr/bin/gcov-tool
ln -sf /usr/bin/lto-dump-$GCC_VERSION /usr/bin/lto-dump

ln -sf /usr/bin/gcc-$GCC_VERSION  /usr/bin/cc
ln -sf /usr/bin/cpp-$GCC_VERSION /usr/bin/cpp

