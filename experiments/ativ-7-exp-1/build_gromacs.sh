BUILD_DIR='../../build'

cd $BUILD_DIR
cmake .. -DGMX_BUILD_OWN_FFTW=ON -DREGRESSIONTEST_DOWNLOAD=ON
make -j

# add curent folder to PATH
PATH=`pwd`:$PATH
