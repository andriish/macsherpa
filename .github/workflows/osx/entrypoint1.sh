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


   export CXX=g++-12
   export CC=gcc-12
   export FC=gfortran-12

git clone --depth 1 https://gitlab.cern.ch/averbyts/sherpa -b cmake
cd sherpa

autoreconf -fi
./configure --with-hepmc2=/usr/local/Cellar/hepmc2/2.06.11 --with-lhapdf=/usr/local/Cellar/lhapdf/6.5.3 -with-libzip=/usr/local//Cellar/libzip/1.9.2

make -j 2
make install


