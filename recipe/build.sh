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

#The skipped Fe_1lXML test is flaky and can randomly fail (Remove once this issue is fixed)
#The hybrid tests and the CoUnfold test need more than 2 mpi processes which is not possible
#on the conda-forge CI
#export juDFT_MPI="mpirun -n {mpi_procs} -mca plm isolated "
#./run_tests.sh -k "not Fe_1lXML and not CoUnfold" --skipmarkers hybrid

cd -

mkdir -p ${PREFIX}/bin
cp build/fleur_MPI ${PREFIX}/bin
cp build/inpgen ${PREFIX}/bin
