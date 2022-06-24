#!/bin/bash
set -ex

ls "${PREFIX}/include/libxml2"
#ls "${PREFIX}/include/libxml2/libxml"

export CC="mpicc"
export CXX="mpicxx"
export FC=mpif90 
export FLEUR_INCLUDEDIR="${PREFIX}/include ${PREFIX}/include/libxml2"
export FLEUR_LIBRARIES="-L${PREFIX}/lib;-lfftw3;-lxml2;-lblas;-llapack;-lscalapack;"

#export LIBXML2_INCLUDE_DIR=${PREFIX}/include/libxml2
#export CFLAGS="${CFLAGS} -I$"
./configure.sh

cd build/include
ls

sed -n '/\x0/ { s/\x0/<NUL>/g; p}' buildinfo.h
sed -n '/\x0/ { s/\x0/<NUL>/g; p}' compileinfo.h

sed 's/\x0//g' buildinfo.h > buildinfo.h
sed 's/\x0//g' compileinfo.h > compileinfo.h

sed -n '/\x0/ { s/\x0/<NUL>/g; p}' buildinfo.h
sed -n '/\x0/ { s/\x0/<NUL>/g; p}' compileinfo.h

cd -

make
cd -

mkdir -p ${PREFIX}/bin
cp build/fleur_MPI ${PREFIX}/bin
cp build/inpgen ${PREFIX}/bin
