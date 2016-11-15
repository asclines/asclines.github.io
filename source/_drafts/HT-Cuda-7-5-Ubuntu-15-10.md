---
title: HT-Cuda_7_5_Ubuntu_15_10
tags:
---

TODO: Below is copy-pasta from wordpress.


This post will explain how to install CUDA Toolkit 7.5 on Ubuntu 15.10. I have personally done this on my Lenovo Y50 Laptop with a NVIDIA GTX 860M.

Before we begin, make sure you system has a CUDA-Enabled NVIDIA card as listed on this site.

Download and Install .deb

Go to the download page and follow the prompts to download the .deb for your machine.
I recommend verifying your download using the checksum tool of your choice before continuing.
To install:

[bash]sudo dpkg -i cuda-repo-ubuntu1504-7-5-local_7.5-18_amd64.deb
sudo apt-get update
sudo apt-get install cuda
[/bash]
Add Path Variables

In either your ~/.bashrc (or if you want every user on your machine, /etc/profile) add these two lines:

[code] export PATH=/usr/local/cuda-7.5/bin/:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda-7.5/lib64:$LD_LIBRARY_PATH[/code]
To verify this and the installation worked enter:

[bash] nvcc --version[/bash]
Compilers

So at this point you are technically done installing CUDA-toolkit 7.5 and if you like go ahead and try to run some CUDA code.
However, at the time of this writing, if you were to try and compile a CUDA program you would get this error:

[code]error -- unsupported GNU version! gcc versions later than 4.9 are not supported![/code]
If you have a GCC compiler version higher than 4.9, which you can check by entering:

[bash]gcc --version[/bash]
you will have to install a lower version gcc.
Now, what if you are like me and you don't want to downgrade your gcc compiler for the whole system? Do what I did and install gcc and g++ 4.9 for CUDA 7.5 by entering these commands: (I believe g++ is optional, but I chose to do it to be safe)

[bash]sudo apt-get install gcc-4.9
sudo apt-get install g++-4.9
sudo ln -s /usr/bin/gcc-4.9 /usr/local/cuda/bin/gcc
sudo ln -s /usr/bin/g++-4.9 /usr/local/cuda/bin/g++[/bash]
In Conclusion

By now, hopefully everything works and you will now be able to use the commands:

[bash]nvcc
cuda-gdb[/bash]
If not, go ahead and post in the comments your problem and let's see if we can't fix your problem and help anyone in the future who may come across that problem.
