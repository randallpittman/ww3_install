#!/bin/bash -e
set -u  # error if using unknown variable!
# -------------------------------------------------------------------- #
# Netcdf and utilities installation script                             #
#                                                                      #
# Original Author : Mickael ACCENSI - IFREMER                          #
# Modified by: Randy Pittman
# License : CC BY-SA                                                   #
# Creation date : 04-05-2020                                           #
# Modication date : 08-09-2022                                         #
# -------------------------------------------------------------------- #

# -------------------------------------------------------------------- #
# Script architecture                                                  #
#                                                                      #
## Section 1 - input arguments                                         #
## Section 2 - download from website                                   #
## Section 3 - extract tar to src                                      #
## Section 4 - initialize compiler environment                         #
## Section 5 - initialize environment variables                        #
## Section 6 - netcdf libraries installation                           #
## Section 7 - nco installation                                        #
## Section 8 - ncview installation                                     #
## Section 9 - cdo installation                                       #
## Section 10 - cdl installation                                       #
## Section 11 - successfull exit message                               #
# -------------------------------------------------------------------- #


####################################################################################################
## Section 1 - input arguments

compiler=GNU

# enable or disable download sources from each provider website
website=1
# extract the sources
extract=1
# install the netcdf libraries
netcdf=1
# install netcdf utilies
nco=1
ncview=0
cdo=1
cdl=0

NETCDF=${NETCDF:-/usr/local/netcdf}
mkdir -p $NETCDF
cd $NETCDF


####################################################################################################
## Section 2 - download from website

# # All apt deps
apt -y install \
    cmake libexpat1 libexpat1-dev libudunits2-dev libudunits2-data libudunits2-0 curl libcurl4-gnutls-dev \
    zlib1g zlib1g-dev antlr libantlr-dev gsl-bin libgsl-dev libpng-dev openssl libssl-dev libjpeg9-dev \
    libaec-dev libxml2-dev python3 python3-distutils python3-numpy

# SW Versions
FLEXVER=2.6.4
HDF5VER=1.10.5
NCVER=4.9.0
NFVER=4.6.0
NCOVER=4.8.1
ESMFVER=8.3.0
NCVIEWVER=2.1.8
JASPERVER=2.0.14
ECCODESVER=2.27.0
G2CVER=1.7.0
CDOVER=1.9.5
NCLVER=6.6.2


if [ ${website} -eq 1 ]; then
    rm -rf TAR
    mkdir -p TAR
    cd TAR

    # flex libexpat udunits can be downloaded here :
    # apt -y install \
    #     libexpat1 libexpat1-dev \
    #     libudunits2-dev libudunits2-data libudunits2-0
    wget \
        https://github.com/westes/flex/releases/download/v$FLEXVER/flex-$FLEXVER.tar.gz

    # hdf5 curl zlib sources can be downloaded here :
    # ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-4/
    # apt -y install \
    #     curl libcurl4-gnutls-dev \
    #     zlib1g zlib1g-dev
    wget \
        https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-${HDF5VER%.*}/hdf5-$HDF5VER/src/hdf5-$HDF5VER.tar.gz

    # netcdf c and fortran sources can be downloaded here :
    # https://www.unidata.ucar.edu/downloads/netcdf/index.jsp
    # examples :
    wget https://github.com/Unidata/netcdf-c/archive/refs/tags/v$NCVER.tar.gz -O netcdf-c-$NCVER.tar.gz
    wget https://github.com/Unidata/netcdf-fortran/archive/refs/tags/v$NFVER.tar.gz -O netcdf-fortran-$NFVER.tar.gz

    # nco netCDF Operator can be downloaded here :
    # http://nco.sourceforge.net
    # https://github.com/nco/nco/archive/
    # apt -y install antlr libantlr-dev gsl-bin libgsl-dev
    wget https://github.com/nco/nco/archive/$NCOVER.tar.gz -O nco-$NCOVER.tar.gz

    # Earth System Modeling Framework
    wget https://github.com/esmf-org/esmf/archive/refs/tags/v$ESMFVER.tar.gz -O esmf-$ESMFVER.tar.gz

    # ncview can be downloaded here :
    # http://meteora.ucsd.edu/~pierce/ncview_home_page.html
    # apt -y install libpng-dev
    wget ftp://cirrus.ucsd.edu/pub/ncview/ncview-$NCVIEWVER.tar.gz

    # openssl can be downloaded here :
    # wget https://www.openssl.org/source/openssl-1.1.1d.tar.gz
    # apt -y install openssl libssl-dev

    # jpeg can be downloaded here :
    # wget http://www.ijg.org/files/jpegsrc.v9d.tar.gz
    # apt -y install libjpeg9-dev

    # jasper can be downloaded here :
    wget https://www.ece.uvic.ca/~frodo/jasper/software/jasper-$JASPERVER.tar.gz

    # eccodes can be downloaded here :
    wget https://confluence.ecmwf.int/download/attachments/45757960/eccodes-$ECCODESVER-Source.tar.gz

    #  grib2 can be downloaded here :
    # wget https://www.nco.ncep.noaa.gov/pmb/codes/GRIB2/g2clib-1.6.0.tar
    wget https://github.com/NOAA-EMC/NCEPLIBS-g2c/archive/refs/tags/v$G2CVER.tar.gz -O g2clib-$G2CVER.tar.gz

    # cdo can be downloaded here :
    # https://code.mpimet.mpg.de/projects/cdo/files
    wget https://code.mpimet.mpg.de/attachments/download/18264/cdo-$CDOVER.tar.gz

    # ncl can be downloaded here :
    wget https://www.earthsystemgrid.org/dataset/ncl.662.src/file/ncl_ncarg-$NCLVER.tar.gz

    cd -
fi

####################################################################################################
## Section 3 - extract tar to src

if [ ${extract} -eq 1 ]; then

    cd $NETCDF
    rm -rf src
    mkdir -p src
    cd src

    echo "extract tar files"
    # netcdf
    tar -xf ../TAR/flex-$FLEXVER.tar.gz
    # tar xf ../TAR/libexpat-2*.tar.gz
    # tar xf ../TAR/udunits-2*.tar.gz
    # tar xf ../TAR/zlib-1.*.tar.gz
    tar -xf ../TAR/hdf5-$HDF5VER.tar.gz
    tar -xf ../TAR/netcdf-c-$NCVER.tar.gz
    tar -xf ../TAR/netcdf-fortran-$NFVER.tar.gz
    # tar xf ../TAR/openssl-1.1.1d.tar.gz
    # tar xf ../TAR/curl-7.*.tar.gz
    # nco
    # tar xf ../TAR/antlr-2*.tar.gz
    # tar xf ../TAR/gsl-2*.tar.gz
    tar -xf ../TAR/esmf-$ESMFVER.tar.gz
    tar -xf ../TAR/nco-$NCOVER.tar.gz
    # ncview
    # tar xf ../TAR/libpng-1*.tar.gz
    tar -xf ../TAR/ncview-$NCVIEWVER.tar.gz
    # cdo and ncl
    # tar xf ../TAR/jpegsrc.v9d.tar.gz
    tar -xf ../TAR/jasper-$JASPERVER.tar.gz
    tar -xf ../TAR/eccodes-$ECCODESVER-Source.tar.gz
    tar -xf ../TAR/g2clib-$G2CVER.tar.gz
    tar -xf ../TAR/cdo-$CDOVER.tar.gz
    tar -xf ../TAR/ncl_ncarg-$NCLVER.tar.gz

    cd -
fi

####################################################################################################
## Section 4 - initialize compiler environment


export comp_c=gcc
export comp_cpp='gcc -E'
export comp_cxx=g++
export comp_f=gfortran

export comp_mpic=mpicc
export comp_mpicpp='mpicc -E'
export comp_mpicxx=mpicxx
export comp_mpif=mpif90

export fcflags='-O3'
export cflags='-O3 -fPIC'
export cpp=''

export ESMF_OS=Linux
export ESMF_COMPILER=gfortran
export ESMF_COMM=openmpi
export ESMF_OPENMP=OFF


####################################################################################################
## Section 5 - initialize environment variables

if [ $extract -eq 1 ]; then
    # only remove built stuff if starting over (extract==1)
    rm -rf ${NETCDF}/bin ${NETCDF}/sbin ${NETCDF}/include ${NETCDF}/lib
    mkdir -p ${NETCDF}/include ${NETCDF}/lib ${NETCDF}/bin
fi

echo 'compiler : ' $compiler
export comp_mpic_exe=$(echo $comp_mpic | awk -F' ' '{print $1}')
echo "$comp_mpic_exe"
export comp_mpif_exe=$(echo $comp_mpif | awk -F' ' '{print $1}')
echo "$comp_mpif_exe"
which $comp_mpic_exe
which $comp_mpif_exe

export OPT_CONF="CPPFLAGS=-I${NETCDF}/include LDFLAGS=-L${NETCDF}/lib --prefix=${NETCDF}"
echo "OPT_CONF : " $OPT_CONF

export PATH=${NETCDF}/bin:${PATH}
echo "PATH : " $PATH

export LD_LIBRARY_PATH=${NETCDF}/lib:${LD_LIBRARY_PATH-""}
echo "LD_LIBRARY_PATH : " $LD_LIBRARY_PATH

export CPATH=${NETCDF}/include:${CPATH-""}
echo "CPATH : " $CPATH



####################################################################################################
## Section 6 - netcdf libraries installation

cd $NETCDF/src

if [ ${netcdf} -eq 1 ]; then

    # FLEX INSTALLATION
    cd flex-*
    echo "configure " $(basename ${PWD})
    ./configure  $OPT_CONF \
        FC="$comp_mpif" \
        CC="$comp_mpic" \
        CPP="$comp_mpicpp" \
        CXX="$comp_mpicxx" \
        CFLAGS="$cflags" CXXFLAGS="$cflags" FCFLAGS="$fcflags" \
        --enable-static=no \
        >& Configure-flex.log
    echo "make " $(basename ${PWD})
    make -j 24 >& Compile-flex.log
    echo "make install " $(basename ${PWD})
    make install >& Install-flex.log
    cd ..

    # HDF5 INSTALLATION
    #                   --enable-debug=all \
    cd hdf5-*
    echo "configure " $(basename ${PWD})
    if [ "${compiler}" == "PGI" ]; then fpic='-fPIC'; else fpic=''; fi
    ./configure  $OPT_CONF \
        FC="$comp_mpif" \
        CC="$comp_mpic" \
        CPP="$comp_mpicpp" \
        CXX="$comp_mpicxx" \
        CFLAGS="$cflags" CXXFLAGS="$cflags" FCFLAGS="$fcflags $fpic" \
        LIBS="-ludunits2" \
        --enable-hl \
        --enable-fortran \
        --enable-parallel \
        --enable-static=no \
        >& Configure-hdf5.log
    echo "make " $(basename ${PWD})
    make -j 24   >& Compile-hdf5.log
    echo "make install " $(basename ${PWD})
    make install >& Install-hdf5.log
    cd ..

    # NETCDF C INSTALLATION
    #                   --enable-logging \
    cd netcdf-c-*
    echo "configure " $(basename ${PWD})
    if [ "${compiler}" == "PGI" ]; then fpic='-fPIC'; else fpic=''; fi
    ./configure  $OPT_CONF \
        FC="$comp_mpif" \
        CC="$comp_mpic" \
        CPP="$comp_mpicpp" \
        CXX="$comp_mpicxx" \
        CFLAGS="$cflags" CXXFLAGS="$cflags" FCFLAGS="$fcflags $fpic" \
        LIBS="-ludunits2" \
        --enable-static=no \
        --enable-parallel-tests \
        --enable-shared \
        >& Configure-netcdf-c.log
    echo "make " $(basename ${PWD})
    make -j 24 >& Compile-netcdf-c.log
    echo "make install " $(basename ${PWD})
    make install >& Install-netcdf-c.log
    cd ..

    # NETCDF FORTRAN INSTALLATION
    #                  --enable-logging \
    cd netcdf-fortran-*
    echo "configure " $(basename ${PWD})
    if [ "${compiler}" == "PGI" ]; then fpic='-fPIC'; else fpic=''; fi
    ./configure  $OPT_CONF \
        FC="$comp_mpif" \
        CC="$comp_mpic" \
        CPP="$comp_mpicpp" \
        CXX="$comp_mpicxx" \
        CFLAGS="$cflags" CXXFLAGS="$cflags" FCFLAGS="$fcflags $fpic" \
    LIBS="-lhdf5hl_fortran -lhdf5_hl -lhdf5_fortran -lhdf5 -ldl -lm -lz -ludunits2" \
        --enable-static=no \
        --enable-parallel-tests \
        --enable-shared \
        >& Configure-netcdf-fortran.log
    echo "make " $(basename ${PWD})
    make -j 24   >& Compile-netcdf-fortran.log
    echo "make install " $(basename ${PWD})
    make install >& Install-netcdf-fortran.log
    cd ..

fi


####################################################################################################
## Section 7 - nco installation

if [ ${nco} -eq 1 ]; then

    # UPDATE ENVIRONMENT
    export PATH=${PATH}:${NETCDF}/bin
    CLIBS=$(${NETCDF}/bin/nc-config --libs)
    echo "CLIBS : " $CLIBS

    # ESMF INSTALLATION
    cd esmf-*
    export ESMF_DIR=$PWD
    export ESMF_INSTALL_PREFIX=$NETCDF
    export ESMF_NETCDF_INCLUDE=$NETCDF/include
    export ESMF_NETCDF_LIBPATH=$NETCDF/lib
    export ESMF_NETCDF=$NETCDF/bin/nc-config
    echo "make " $(basename ${PWD})
    make -j 24  >& Compile-esmf.log
    echo "make install " $(basename ${PWD})
    make install >& Install-esmf.log
    cd ..


    # FLEX NEEDED FOR UDUNITS
    # EXPAT NEEDED FOR UDUNITS
    # UDUNITS NEEDED FOR NCO
    # ESMF NEEDED FOR NCO GRID MAPPING

    # NCO INSTALLATION
    cd nco-*
    echo "configure " $(basename ${PWD})
    # ./configure  $OPT_CONF \
    #     FC="$comp_mpif" \
    #     CC="$comp_mpic" \
    #     CPP="$comp_mpicpp" \
    #     CXX="$comp_mpicxx" \
    #     CFLAGS="$cflags" CXXFLAGS="$cflags" FCFLAGS="$fcflags" \
    #     UDUNITS2_PATH="$NETCDF" \
    #     GSL_ROOT="$NETCDF" \
    #     ESMF_ROOT="$NETCDF" \
    #     ESMF_LIB="$(find $NETCDF/lib/libO/ -mindepth 1 -type d)" \
    #     ESMF_INC="$NETCDF/include" \
    #     LIBS="$CLIBS" \
    #     --enable-ncap2 \
    #     --disable-openmp \
    #     --enable-shared \
    #     --enable-static=no \
    #     >& Configure-nco.log
    ./configure  $OPT_CONF \
        FC="$comp_mpif" \
        CC="$comp_mpic" \
        CPP="$comp_mpicpp" \
        CXX="$comp_mpicxx" \
        CFLAGS="$cflags" CXXFLAGS="$cflags" FCFLAGS="$fcflags" \
        ESMF_ROOT="$NETCDF" \
        ESMF_LIB="$(find $NETCDF/lib/libO/ -mindepth 1 -type d)" \
        ESMF_INC="$NETCDF/include" \
        LIBS="$CLIBS" \
        --enable-ncap2 \
        --disable-openmp \
        --enable-shared \
        --enable-static=no \
        >& Configure-nco.log
    echo "make " $(basename ${PWD})
    make -j 24  >& Compile-nco.log
    echo "make install " $(basename ${PWD})
    make install >& Install-nco.log
    cd ..
fi


####################################################################################################
## Section 8 - ncview installation

if [ ${ncview} -eq 1 ]; then

    # NCVIEW INSTALLATION
    # MUST BE DONE ON THE FRONT-END NODE FOR X-SERVER ENABLING
    cd ncview-*
    echo "configure " $(basename ${PWD})
    ./configure  $OPT_CONF \
        FC="$comp_mpif" \
        CC="$comp_mpic" \
        CPP="$comp_mpicpp" \
        CXX="$comp_mpicxx" \
        CFLAGS="$cflags" CXXFLAGS="$cflags" FCFLAGS="$fcflags" \
        LIBS="${CLIBS-''} -ludunits2 -lpng -lpng16" \
        --x-libraries=/usr/lib64 --x-includes=/usr/include/X11 \
        >& Configure-ncview.log
    echo "make " $(basename ${PWD})
    make -j 24 >& Compile-ncview.log
    echo "make install " $(basename ${PWD})
    make install >& Install-ncview.log
    cd ..
fi

####################################################################################################
## Section 9 - cdo installation

if [ ${cdo} -eq 1 ]; then

    # module load cmake # for jasper and eccodes

    # JASPER INSTALLATION
    cd jasper-*
    SRCDIR=$(basename ${PWD})
    echo "configure $SRCDIR"
    # cmake -G "Unix Makefiles" -H$PWD -B$PWD/build \
    #       -DJPEG_INCLUDE_DIR=${NETCDF}/include \
    #       -DJPEG_LIBRARY=${NETCDF}/lib/libjpeg.so \
    #       -DCMAKE_INSTALL_PREFIX=${NETCDF} \
    #     >& Configure-jasper.log
    cmake -G "Unix Makefiles" -H$PWD -B$PWD/build \
          -DCMAKE_INSTALL_PREFIX=${NETCDF} \
        >& Configure-jasper.log
    cd build
    echo "make $SRCDIR"
    make clean all >& Clean-jasper.log
    echo "install $SRCDIR"
    make install >& Install-jasper.log
    cd ../..
    if [ -d ${NETCDF}/lib64 ]; then
        ln -rfsn ${NETCDF}/lib64/*so* ${NETCDF}/lib/
    fi

    # #. /appli/anaconda/versions/4.7.12/etc/profile.d/conda.sh
    # #conda activate /appli/anaconda/versions/4.7.12
    # module load conda/4.7.12

    # ECCODES INSTALLATION
    cd eccodes-*
    SRCDIR=$(basename ${PWD})
    echo "configure $SRCDIR"
    mkdir build
    cd build
    # cmake -DNetCDF_INCLUDE_DIRS=${NETCDF}/include/netcdf.inc \
    #       -DNetCDF_LIBRARIES=${NETCDF}/lib/libnetcdf.so \
    #       -DJPEG_INCLUDE_DIR=${NETCDF}/include \
    #       -DJPEG_LIBRARY=${NETCDF}/lib/libjpeg.so \
    #       -DCMAKE_INSTALL_PREFIX=${NETCDF} \
    #       -DENABLE_NETCDF=ON \
    #         ../ >& Configure-eccodes.log
    cmake -DNetCDF_INCLUDE_DIRS=${NETCDF}/include/netcdf.inc \
          -DNetCDF_LIBRARIES=${NETCDF}/lib/libnetcdf.so \
          -DCMAKE_INSTALL_PREFIX=${NETCDF} \
          -DENABLE_NETCDF=ON \
            ../ >& Configure-eccodes.log
    echo "make $SRCDIR"
    make >& Compile-eccodes.log
    echo "install $SRCDIR"
    make install >& Install-eccodes.log
    #pip install --install-option="--prefix=${NETCDF}" eccodes-python >& PipInstall-eccodes.log
    cd ../..

# #conda deactivate # deactivate conda
# module unload conda/4.7.12
# module unload cmake # for jasper and eccodes

# CDO INSTALLATION
    cd cdo-*
    SRCDIR=$(basename ${PWD})
    echo "configure $SRCDIR"
    if [ "${compiler}" == "MPT" ]; then CLIBS="$CLIBS -L$MPI_ROOT/lib -lmpi -lmpi++abi1002 -lsma"; fi
    #                if [ "${compiler}" == "PGI" ]; then CLIBS="$CLIBS -L$MPI_ROOT/lib -lmpi -lmpi_cxx -lnuma -loshmem"; fi
    ./configure  $OPT_CONF \
        CFLAGS="$cflags $cpp" CXXFLAGS="$cflags $cpp" FFLAGS="$fcflags" \
        FC="$comp_mpif" \
        F77="$comp_mpif" \
        CC="$comp_mpic" \
        CPP="$comp_mpicpp" \
        CXX="$comp_mpicxx" \
        LIBS="$CLIBS -L${NETCDF}/lib -ljpeg" \
        --enable-static=no \
        --with-netcdf=yes \
        --with-hdf5=yes \
        --with-udunits2=yes \
        --with-curl=yes \
        --with-eccodes=yes \
        --with-threads=yes \
        --disable-openmp \
        >& Configure-cdo.log
    echo "make $SRCDIR"
    make -j 24 >& Compile-cdo.log
    echo "make install $SRCDIR"
    make install >& Install-cdo.log
    cd ..
fi

####################################################################################################
## Section 10 - cdl installation

if [ ${cdl} -eq 1 ]; then

	echo 'NCL must be installed interactively'

# G2CLIB INSTALLATION : must be done interactively
#                cd g2clib-1.6*
#                rm -f libg2c_v1.6.0.a
#                echo "make " $(basename ${PWD})
#                # sed -e "s/DEFS=-DUSE_JPEG2000 -DUSE_PNG/DEFS=-DUSE_PNG/g" makefile > makefile
#                # sed -e "s:??:INC=-I${NETCDF}/include" makefile > makefile
#                # sed -e "s/CC=gcc/CC=${comp_c}/g" makefile > makefile
#                make >& Compile-g2clib.log
#                 cp libg2c_v1.6.0.a ${NETCDF}/lib/
#                cd ..

# NCL INSTALLATION : must be done interactively
#                cd ncl_ncarg-6.6*
#                echo "configure " $(basename ${PWD})
#                ./Configure done interactive
#                 export NCARG_ROOT=${NETCDF}
#                 make Everything >& Compile-ncl.log
#                 make All >& Install-ncl.log


fi

####################################################################################################
## Section 11 - successfull exit message

echo ''
echo 'INSTALLATION CORRECTLY DONE'
echo ''
echo 'in order to use this netcdf library'
echo 'you must add this to your bashrc or cshrc : '
echo ''
echo -n '   export PATH=${PATH}'
echo ":${NETCDF}/bin"
echo -n '   export CPATH=${CPATH}'
echo ":${NETCDF}/include"
echo -n '   export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}'
echo ":${NETCDF}/lib"
echo 'or'
echo -n '   setenv PATH ${PATH}'
echo ":${NETCDF}/bin"
echo -n '   setenv CPATH ${CPATH}'
echo ":${NETCDF}/include"
echo -n '   setenv LD_LIBRARY_PATH ${LD_LIBRARY_PATH}'
echo ":${NETCDF}/lib"

