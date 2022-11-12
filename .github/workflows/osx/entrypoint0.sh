#!/bin/sh -l
set -x
#exit
export TOP=$(pwd)
mkdir LOCAL
cd LOCAL
brew tap davidchall/hep
brew install hepmc lhapdf  
brew install wget coreutils  
brew install gnu-sed
brew install gcc
brew install cmake
brew install autoconf 
brew install automake 
brew install libtool 
brew install pkg-config

   export CXX=g++-12
   export CC=gcc-12
   export FC=gfortran-12

git clone https://gitlab.cern.ch/averbyts/sherpa
cd sherpa
git checkout cmake
cmake -S . -B BUILD -DCMAKE_INSTALL_PREFIX=$(pwd)/CM \
          -DCMAKE_CXX_FLAGS="-O2 -g -fcx-fortran-rules" -DCMAKE_C_FLAGS="-O2 -g" -DCMAKE_Fortran_FLAGS="-O2 -g" \
          -DLHAPDF_DIR=/usr/local/Cellar/lhapdf/6.5.3  \
          -DSHERPA_ENABLE_MCFM=OFF  \
          -DSHERPA_ENABLE_HEPMC3_ROOT=OFF  \
          -DSHERPA_ENABLE_MANUAL=ON  \
          -DHepMC2_DIR=/usr/local/Cellar/hepmc2/2.06.11 \
           -DSHERPA_ENABLE_RECOLA=OFF \
           -DSHERPA_ENABLE_HZTOOL=OFF \
           -DSHERPA_ENABLE_BLACKHAT=OFF \
           -DSHERPA_ENABLE_RIVET=OFF \
           -DSHERPA_ENABLE_GOSAM=OFF \
           -DCMAKE_CXX_STANDARD=11 \
           -DSHERPA_ENABLE_PYTHIA8=OFF \
           -DSHERPA_ENABLE_OPENLOOPS=OFF \
          
cmake --build BUILD -j 2
cmake --install BUILD


