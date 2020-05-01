# Install requirements
sudo apt-update
sudo apt-get install -y wget make gcc libgfortran3 sysstat libibnetdisc-dev openmpi-bin libopenmpi-dev libhdf5-openmpi-dev gfortran build-essential git cmake 

# Set SSH key
ssh-keygen -t rsa -q -f "$HOME/.ssh/id_rsa" -N ""
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

# Compile Gromacs
wget ftp://ftp.gromacs.org/pub/gromacs/gromacs-2020.2.tar.gz
tar -xfz  gromacs-2020.2.tar.gz
cd gromacs-2020.2
mkdir build
cd build
cmake .. -DGMX_BUILD_OWN_FFTW=ON -DREGRESSIONTEST_DOWNLOAD=ON -DGMX_MPI=on -DGMX_BUILD_MDRUN_ONLY=on
make
sudo make install 
source /usr/local/gromacs/bin/GMXRC
sudo -l echo "source /usr/local/gromacs/bin/GMXRC" >> ~/.bashrc
