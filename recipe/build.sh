#!/bin/bash
set -ex

export CC="mpicc"
export CXX="mpicxx"
export FC=mpif90 
export FLEUR_INCLUDEDIR="${PREFIX}/include ${PREFIX}/include/libxml2"
export FLEUR_LIBRARIES="-lfftw3;-lxml2;-lopenblas;-llapack;-lscalapack;"

./configure.sh

cd build; make -j${CPU_COUNT}; cd -

mkdir -p ${PREFIX}/bin
cp build/fleur_MPI ${PREFIX}/bin
cp build/inpgen ${PREFIX}/bin
