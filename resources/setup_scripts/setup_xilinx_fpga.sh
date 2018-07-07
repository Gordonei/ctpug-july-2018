#!/usr/bin/env bash

echo "Retrieving and setting up SDAccel"

# Getting AWS FPGA Repo
git clone https://github.com/aws/aws-fpga.git $AWS_FPGA_REPO_DIR

# Setting up SDAccel
cd $AWS_FPGA_REPO_DIR && source sdk_setup.sh && source hdk_setup.sh && source sdaccel_setup.sh && cd -

# Setting up the runtime environment
echo "Setting up the runtime environment"
source /opt/Xilinx/SDx/2017.4.rte.dyn/setup.sh

# Installing clinfo
echo "Installing clinfo"
sudo yum -y install clinfo

# Install Python3, PyOpenCL and Numba
echo "Installing Python3, PyOpenCL and Numba"
sudo yum -y install python34 python34-pip python34-devel python34-cffi ipython llvm5.0-devel
# Installing slightly older version of llvmlite as only LLVM5 is available for CentOS
LLVM_CONFIG=/usr/bin/llvm-config-5.0-64 sudo -H -E pip3 install llvmlite==0.21.0
sudo -H pip3 install pyopencl
