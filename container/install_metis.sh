#!/bin/bash -e

## Get archives

export METIS=${METIS:-/usr/local/metis}
mkdir -p $METIS && cd $METIS

export PREFIX=$METIS

download=1
extract=1
build=1

if [ $download -eq 1 ]; then
    mkdir -p TAR && cd TAR
    wget http://glaros.dtc.umn.edu/gkhome/fetch/sw/metis/metis-5.1.0.tar.gz
    wget http://glaros.dtc.umn.edu/gkhome/fetch/sw/parmetis/parmetis-4.0.3.tar.gz
    cd -
fi

if [ $extract -eq 1 ]; then
    mkdir -p src && cd src
    tar -xf ../TAR/metis-5.1.0.tar.gz
    tar -xf ../TAR/parmetis-4.0.3.tar.gz
    cd -
fi

if [ $build -eq 1 ]; then
    cd src

    # Build METIS
    cd metis-*
    make config shared=1 cc=gcc prefix=$PREFIX &> Configure_METIS.log
    make &> Compile_METIS.log
    make install &> Install_METIS.log
    cd ..

    cd parmetis-*
    make config shared=1 prefix=$PREFIX cc=mpicc cxx=mpicxx &> Configure_ParMETIS.log
    make &> Compile_ParMETIS.log
    make install &> Install_ParMETIS.log
    cd ..

    cd -
fi

echo ''
echo 'INSTALLATION CORRECTLY DONE'
echo ''
echo 'in order to use METIS and ParMETIS'
echo 'you must add this to your bashrc or cshrc : '
echo ''
echo -n '   export PATH=${PATH}'
echo ":${METIS}/bin"
echo -n '   export CPATH=${CPATH}'
echo ":${METIS}/include"
echo -n '   export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}'
echo ":${METIS}/lib"
echo 'or'
echo -n '   setenv PATH ${PATH}'
echo ":${METIS}/bin"
echo -n '   setenv CPATH ${CPATH}'
echo ":${METIS}/include"
echo -n '   setenv LD_LIBRARY_PATH ${LD_LIBRARY_PATH}'
echo ":${METIS}/lib"

