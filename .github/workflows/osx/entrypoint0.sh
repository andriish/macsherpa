#!/bin/sh -l
set -x
#exit
export TOP=$(pwd)
mkdir LOCAL
cd LOCAL
brew tap davidchall/hep
brew install hepmc lhapdf  hepmc3 libzip
brew install wget coreutils  
brew install gnu-sed
brew install gcc
brew install cmake
brew install autoconf 
brew install automake 
brew install libtool 
brew install pkg-config


export FC=gfortran-12

git clone --depth 1 https://gitlab.com/andriish/sherpa -b cmake
cd sherpa
#-fcx-fortran-rules

cmake -S . -B BUILD -DCMAKE_INSTALL_PREFIX=$(pwd)/CM \
           -DCMAKE_CXX_FLAGS="-O2 -g " -DCMAKE_C_FLAGS="-O2 -g" -DCMAKE_Fortran_FLAGS="-O2 -g" \
           -DLHAPDF_DIR=/usr/local/Cellar/lhapdf/6.5.3  \
           -DSHERPA_ENABLE_MCFM=OFF  \
           -DSHERPA_ENABLE_HEPMC3_ROOT=OFF  \
           -DSHERPA_ENABLE_MANUAL=OFF  \
           -DHepMC2_DIR=/usr/local/Cellar/hepmc2/2.06.11 \
           -DSHERPA_ENABLE_RECOLA=OFF \
           -DSHERPA_ENABLE_HZTOOL=OFF \
           -DSHERPA_ENABLE_ROOT=OFF \
           -DSHERPA_ENABLE_BLACKHAT=OFF \
           -DSHERPA_ENABLE_RIVET=OFF \
           -DSHERPA_ENABLE_GOSAM=OFF \
           -DSHERPA_ENABLE_MADLOOP=OFF \
           -DSHERPA_ENABLE_PYTHIA8=OFF \
           -DSHERPA_ENABLE_OPENLOOPS=OFF \
           -DSHERPA_ENABLE_EWSUD=ON \
           -DSHERPA_ENABLE_TESTING=ON \
          
cmake --build BUILD -j 2
cmake --install BUILD
ctest --test-dir BUILD
lhapdf install PDF4LHC21_40_pdfas
CM/bin/Sherpa Examples/CI/LO_Z/Sherpa.yaml


