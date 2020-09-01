# Chainer Docker Image for NVIDIA Jetson


This repository contains the Dockerfile for building Chainer for NVIDIA Jetson.


## Supported Version

* Chainer v7.7.0
* CuPy v7.8.0
* ChainerCV v0.13.1


## Docker Default Runtime

The following instructions are quoted from [dusty-nv/jetson-containers](https://github.com/dusty-nv/jetson-containers/blob/master/README.md).

To enable access to the CUDA compiler (nvcc) during `docker build` operations, add `"default-runtime": "nvidia"` to your `/etc/docker/daemon.json` configuration file before attempting to build the containers:

``` json
{
    "runtimes": {
        "nvidia": {
            "path": "nvidia-container-runtime",
            "runtimeArgs": []
        }
    },

    "default-runtime": "nvidia"
}
```

You will then want to restart the Docker service or reboot your system before proceeding.

``` bash
$ sudo service docker restart
```


## Building the Docker Image

To build the docker image from a Jetson device running [JetPack 4.4](https://developer.nvidia.com/embedded/jetpack), first clone this repo:

``` bash
$ git clone https://github.com/KeitetsuWorks/jetson-chainer-docker.git
$ cd jetson-chainer-docker/build
$ ./build.sh
```

## Running the Container

``` bash
$ cd jetson-chainer-docker/run
$ ./run.sh
```


## License

* MIT

