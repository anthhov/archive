FROM ubuntu:22.04

WORKDIR /etc/configs

COPY shared/install_python.sh ./
RUN ./install_python.sh

ENV GCC_VERSION=10
COPY shared/install_gcc.sh ./
RUN ./install_gcc.sh
