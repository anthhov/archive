#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset
set -o xtrace

PYTHON_VERSION=${PYTHON_VERSION:-3.11.10}

apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install --yes --no-install-recommends \
  libbz2-dev \
  libffi-dev \
  libssl-dev \
  libsqlite3-dev \
  liblzma-dev \
  zlib1g-dev \

wget https://www.python.org/ftp/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tgz
tar -xzf Python-$PYTHON_VERSION.tgz
cd Python-$PYTHON_VERSION

./configure --enable-optimizations
make build_all -j "$(nproc --all)"
make altinstall

ln --symbolic --force /usr/local/bin/python3.11 /usr/local/bin/python3

cd -
rm --recursive --force Python-$PYTHON_VERSION*
