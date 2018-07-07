#!/usr/bin/env bash

echo "Generating en_ZA and en_GB locales"
sudo locale-gen en_ZA.UTF-8
sudo locale-gen en_GB.UTF-8

echo "Updating OS Repos and installing aptitude"
sudo apt-get update && sudo apt-get -y install aptitude

echo "Installing OpenCL headers and clinfo"
sudo aptitude -y install opencl-headers clinfo lsb-core

echo "Installing Intel support"
wget http://registrationcenter-download.intel.com/akdlm/irc_nas/12556/opencl_runtime_16.1.2_x64_rh_6.4.0.37.tgz
tar -xf opencl_runtime_16.1.2_x64_rh_6.4.0.37.tgz
sudo ./opencl_runtime_16.1.2_x64_rh_6.4.0.37/install.sh --cli-mode

echo "Installing PyOpenCL and Numba"
sudo aptitude -y install python3-pip python3-tk libffi-dev
sudo -H pip3 install pyopencl

echo "Testing Intel OpenCL Platform with PyOpenCL"
python3 -c "import pyopencl;print([platform.name for platform in pyopencl.get_platforms()])"

exit $(python3 -c "import sys;import pyopencl;sys.exit(len([platform for platform in pyopencl.get_platforms() if platform.name=='Intel(R) OpenCL']) == 0)")
