#!/usr/bin/env bash

echo "Generating en_ZA and en_GB locales"
sudo locale-gen en_ZA.UTF-8
sudo locale-gen en_GB.UTF-8

echo "Updating OS Repos and installing aptitude"
sudo apt-get update && sudo apt-get -y install aptitude

echo "Installing OpenCL headers and clinfo"
sudo aptitude -y install opencl-headers clinfo

echo "Installing NVIDIA support"
sudo aptitude -y install nvidia-opencl-dev nvidia-opencl-icd-384

echo "Loading NVIDIA drivers"
sudo modprobe nvidia

echo "Installing PyOpenCL and Numba"
sudo aptitude -y install python3-pip python3-tk libffi-dev
sudo -H pip3 install pyopencl

echo "Testing NVIDIA OpenCL Platform with PyOpenCL"
python3 -c "import pyopencl;print([platform.name for platform in pyopencl.get_platforms()])"

exit $(python3 -c "import sys;import pyopencl;sys.exit(len([platform for platform in pyopencl.get_platforms() if platform.name=='NVIDIA CUDA']) == 0)")
