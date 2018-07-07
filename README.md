# Cape Town Python User Group July 2018
Gordon Inggs, 2018 (gordon.e.inggs@ieee.org)

Hello, this is a repo will all of the content from my talk on 7 July, 2018. If you were there, I hope you enjoyed the talk!

## Contents
From the root of the repo, these are the contents:
```bash
.
├── code # All code used
│   ├── CTPUG_OpenCL_Talk.ipynb
│   ├── java_hash.cl
│   └── vector_sum.cl
├── LICENSE
├── resources
│   ├── reading # Some of the recommended reading
│   │   ├── Debunking100xMyth.pdf
│   │   ├── TheFreeLunchIsOver.pdf
│   │   └── ViewFromBerkeley.pdf
│   └── setup_scripts # Setup scripts - tested on AWS EC2 instances
│       ├── setup_intel_cpu.sh # Assuming Ubuntu 16.04
│       ├── setup_nvida_gpu.sh # Assuming Ubuntu 16.04
│       └── setup_xilinx_fpga.sh # Assuming AWS FPGA Developer AMI
└── slides # Slides
    └── CTPUG_Talk_July2018.pdf
```

## Getting Started
In the `resources` directory, there is a sub-directory `setup_scripts` with bash scripts that can be used to setup PyOpenCL.

The Intel CPU and GPU setup assumed Ubuntu 16.04, whilst the Xilinx FPGA setup assumes the [AWS FPGA Developer AMI](https://aws.amazon.com/marketplace/pp/B06VVYBLZZ).
