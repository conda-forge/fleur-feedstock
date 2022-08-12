#!/bin/bash
set -ex

export CC="mpicc"
export CXX="mpicxx"
export FC=mpif90
if [[ ! -z "$MACOSX_DEPLOYMENT_TARGET" ]]; then
  export FLEUR_INCLUDEDIR="${PREFIX}/include ${PREFIX}/include/libxml2"
  export FLEUR_LIBRARIES="-lfftw3;-lxml2;-lblas;-llapack;-lscalapack;"
else
  export FLEUR_INCLUDEDIR="${PREFIX}/include ${PREFIX}/include/libxml2"
  export FLEUR_LIBRARIES="-lfftw3;-lxml2;-lopenblas;-llapack;-lscalapack;"
fi


./configure.sh

cd build; make -j${CPU_COUNT}; cd -

mkdir -p ${PREFIX}/bin
cp build/fleur_MPI ${PREFIX}/bin
cp build/inpgen ${PREFIX}/bin
