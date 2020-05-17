#!/bin/bash
# Install requirements
echo "Installing dependencie..." >> /home/ubuntu/progress.txt
sudo apt update
sudo apt install -y wget make gcc libgfortran3 sysstat libibnetdisc-dev openmpi-bin libopenmpi-dev libhdf5-openmpi-dev gfortran build-essential git cmake 

# Set SSH key
echo "Setting SSH key..." >> /home/ubuntu/progress.txt
ssh-keygen -t rsa -q -f "/home/ubuntu/.ssh/id_rsa" -N ""
cat /home/ubuntu/.ssh/id_rsa.pub >> /home/ubuntu/.ssh/authorized_keys

cd ../../
mkdir build
cd build
echo "Building Gromacs..." >> /home/ubuntu/progress.txt
cmake .. -DGMX_BUILD_OWN_FFTW=ON -DREGRESSIONTEST_DOWNLOAD=ON -DGMX_MPI=on
make
sudo make install
source /usr/local/gromacs/bin/GMXRC
sudo -l echo "source /usr/local/gromacs/bin/GMXRC" >> ~/.bashrc
cd ~
echo "Removing source files" >> /home/ubuntu/progress.txt
rm ~/gromacs-2020.2 -rf # remove source files

# Downloading the simulation input
echo "Downloading the simulation input!" >> /home/ubuntu/progress.txt
wget https://github.com/fopor/gromacs-mo833a/raw/ativi-5-exp-1/experiments/ativ-5-exp-1/em.tpr -P /home/ubuntu

echo "Done!" >> /home/ubuntu/progress.txt