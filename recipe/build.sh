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

cd build; make -j${CPU_COUNT}

#The skipped test is flaky and can randomly fail (Remove once this issue is fixed)
./run_tests.sh -k "-Fe_Tetra_noSYM"

cd -

mkdir -p ${PREFIX}/bin
cp build/fleur_MPI ${PREFIX}/bin
cp build/inpgen ${PREFIX}/bin
