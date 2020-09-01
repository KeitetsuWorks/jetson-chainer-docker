#!/bin/bash

##
## @file        run.sh
## @brief       Script to run the Docker Image
## @author      Keitetsu
## @date        2020/07/25
## @copyright   Copyright (c) 2020 Keitetsu
## @par         License
##              This software is released under the MIT License.
##

xhost +local:root

docker run \
    --runtime nvidia \
    --interactive \
    --tty \
    --net host \
    --rm \
    --name jetson-chainer \
    --env DISPLAY=${DISPLAY} \
    --env QT_X11_NO_MITSHM=1 \
    --volume /tmp/.X11-unix:/tmp/.X11-unix:rw \
    --volume /data:/data \
    keitetsu/jetson-chainer:7.7.0-cuda10.2-l4t-r32.4.3 \
    /bin/bash

