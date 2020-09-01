#!/bin/bash -eu

##
## @file        build.sh
## @brief       Script to build the Docker Image
## @author      Keitetsu
## @date        2020/07/25
## @copyright   Copyright (c) 2020 Keitetsu
## @par         License
##              This software is released under the MIT License.
##

docker build \
    --tag keitetsu/jetson-chainer:7.7.0-cuda10.2-l4t-r32.4.3 \
    .

