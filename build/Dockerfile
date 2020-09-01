##
## @file        Dockerfile
## @brief       Dockerfile for Chainer on Jetson
## @author      Keitetsu
## @date        2020/07/25
## @copyright   Copyright (c) 2020 Keitetsu
## @par         License
##              This software is released under the MIT License.
##

FROM nvcr.io/nvidia/l4t-base:r32.4.3

LABEL maintainer="KeitetsuWorks@users.noreply.github.com"

ARG OPENCV_VERSION=3.4.11

##
## install Chainer dependencies
##
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get upgrade -y -qq && \
    apt-get install -y -qq --no-install-recommends \
        wget \
        unzip \
        build-essential \
        checkinstall \
        cmake \
        pkg-config \
        yasm \
        gfortran \
        python3-dev \
        python3-tk \
        python3-pyqt4 \
        python3-pip \
        python3-setuptools \
        locales \
        tzdata \
        gosu \
        sudo && \
    apt-get install -y -qq --no-install-recommends \
        libjpeg8-dev \
        libopenexr-dev \
        libpng-dev \
        libtiff5-dev \
        libwebp-dev && \
    apt-get install -y -qq --no-install-recommends \
        libavcodec-dev \
        libavformat-dev \
        libswscale-dev \
        libxine2-dev \
        libv4l-dev && \
    apt-get install -y -qq --no-install-recommends \
        libgstreamer1.0-dev \
        libgstreamer-plugins-base1.0-dev && \
    apt-get install -y -qq --no-install-recommends \
        qt5-default && \
    apt-get install -y -qq --no-install-recommends \
        libfaac-dev \
        libmp3lame-dev \
        libvorbis-dev && \
    apt-get install -y -qq --no-install-recommends \
        libtheora-dev \
        libxvidcore-dev \
        x264 && \
    apt-get install -y -qq --no-install-recommends \
        libopencore-amrnb-dev \
        libopencore-amrwb-dev && \
    apt-get install -y -qq --no-install-recommends \
        libavresample-dev && \
    apt-get install -y -qq --no-install-recommends \
        v4l-utils && \
    apt-get install -y -qq --no-install-recommends \
        libatlas-base-dev \
        libeigen3-dev \
        libtbb2 \
        libtbb-dev && \
    apt-get install -y -qq --no-install-recommends \
        libgflags-dev \
        libgoogle-glog-dev \
        libprotobuf-dev \
        protobuf-compiler && \
    apt-get install -y -qq --no-install-recommends \
        libgphoto2-dev && \
    apt-get install -y -qq --no-install-recommends \
        libhdf5-dev && \
    apt-get install -y -qq --no-install-recommends \
        zlib1g-dev && \
    \
    apt-get clean && \
    apt-get autoclean && \
    \
    rm -rf /tmp/* && \
    rm -rf /var/tmp/* && \
    rm -rf /var/cache/* && \
    rm -rf /var/lib/apt/lists/* && \
    ln -fs /usr/bin/python3.6 /usr/bin/python

##
## install OpenCV
##
RUN python3 -m pip install --no-cache-dir cython && \
    python3 -m pip install --no-cache-dir numpy && \
    cd /tmp && \
    wget --quiet --show-progress --progress=bar:force:noscroll --no-check-certificate \
        https://github.com/opencv/opencv/archive/${OPENCV_VERSION}.zip -O opencv-${OPENCV_VERSION}.zip && \
    unzip ./opencv-${OPENCV_VERSION}.zip && \
    wget --quiet --show-progress --progress=bar:force:noscroll --no-check-certificate \
        https://github.com/opencv/opencv_contrib/archive/${OPENCV_VERSION}.zip -O opencv_contrib-${OPENCV_VERSION}.zip && \
    unzip ./opencv_contrib-${OPENCV_VERSION}.zip && \
    cd ./opencv-${OPENCV_VERSION} && \
    mkdir ./build && \
    cd ./build && \
    cmake \
        -D BUILD_EXAMPLES=OFF \
        -D BUILD_TESTS=OFF \
        -D BUILD_PERF_TESTS=OFF \
        -D BUILD_DOCS=OFF \
        -D BUILD_opencv_java=OFF \
        -D BUILD_NEW_PYTHON_SUPPORT=ON \
        -D BUILD_opencv_python2=OFF \
        -D BUILD_opencv_python3=ON \
        -D CMAKE_BUILD_TYPE=RELEASE \
        -D CMAKE_INSTALL_PREFIX=/usr/local \
        -D OPENCV_ENABLE_NONFREE=ON \
        -D OPENCV_EXTRA_MODULES_PATH=/tmp/opencv_contrib-${OPENCV_VERSION}/modules \
        -D WITH_CUDA=ON \
        -D ENABLE_FAST_MATH=1 \
        -D CUDA_FAST_MATH=1 \
        -D WITH_CUBLAS=ON \
        -D CUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda \
        -D CUDA_ARCH_BIN="5.3" \
        -D CUDA_ARCH_PTX="" \
        -D WITH_QT=ON \
        -D WITH_TBB=ON \
        -D WITH_EIGEN=ON \
        -D WITH_V4L=ON \
        .. && \
    export NUMPROC=$(nproc --all) && \
    make -j${NUMPROC} install && \
    ldconfig && \
    cd /tmp && \
    rm -rf /tmp/*

##
## install Chainer
##
RUN python3 -m pip install --no-cache-dir scipy && \
    python3 -m pip install --no-cache-dir matplotlib && \
    python3 -m pip install --no-cache-dir seaborn && \
    python3 -m pip install --no-cache-dir h5py
RUN export CUDA_PATH=/usr/local/cuda-10.2/targets/aarch64-linux && \
    export NVCC=/usr/local/cuda-10.2/bin/nvcc && \
    python3 -m pip install --no-cache-dir chainer==7.7.0 -vvvv && \
    python3 -m pip install --no-cache-dir cupy==7.8.0 -vvvv && \
    python3 -m pip install --no-cache-dir chainercv==0.13.1

##
## locale settings
##
RUN locale-gen en_US.UTF-8 && \
    update-locale && \
    ln -fs /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata && \
    echo 'Asia/Tokyo' > /etc/timezone
ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8

##
## ENTRYPOINT settings
##
COPY files/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["/bin/bash", "-l"]
