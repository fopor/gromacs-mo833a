BUILD_DIR='../../build'

mkdir -p $BUILD_DIR
cd $BUILD_DIR
cmake .. -DGMX_BUILD_OWN_FFTW=ON -DREGRESSIONTEST_DOWNLOAD=ON
make -j 10

# add curent folder to PATH
PATH=`pwd`:$PATH
