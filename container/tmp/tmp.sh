#!/bin/bash

    rm -rf TAR
    mkdir -p TAR
    cd TAR

    # flex libexpat udunits can be downloaded here :
    wget \
        https://github.com/westes/flex/releases/download/v2.6.4/flex-2.6.4.tar.gz \
        https://github.com/libexpat/libexpat/archive/R_2_2_5.tar.gz \
        ftp://ftp.unidata.ucar.edu/pub/udunits/udunits-2.2.26.tar.gz
    mv R_2_2_5.tar.gz libexpat-2.2.5.tar.gz

    # hdf5 curl zlib sources can be downloaded here :
    # ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-4/
    wget \
        https://curl.haxx.se/download/curl-7.67.0.tar.gz \
        https://www.zlib.net/zlib-1.2.11.tar.gz \
        https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.10/hdf5-1.10.5/src/hdf5-1.10.5.tar.gz


    # netcdf c and fortran sources can be downloaded here :
    # https://www.unidata.ucar.edu/downloads/netcdf/index.jsp
    # examples :
    wget \
        ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-c-4.7.3.tar.gz \
        ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-fortran-4.5.2.tar.gz

    # nco netCDF Operator can be downloaded here :
    # http://nco.sourceforge.net
    # https://github.com/nco/nco/archive/
    wget \
        http://dust.ess.uci.edu/nco/antlr-2.7.7.tar.gz \
        ftp://ftp.gnu.org/gnu/gsl/gsl-2.5.tar.gz \
        https://github.com/nco/nco/archive/4.8.1.tar.gz
    mv 4.8.1.tar.gz nco-4.8.1.tar.gz


    # ncview can be downloaded here :
    # http://meteora.ucsd.edu/~pierce/ncview_home_page.html
    wget \
        https://download.sourceforge.net/libpng/libpng-1.6.34.tar.gz \
        ftp://cirrus.ucsd.edu/pub/ncview/ncview-2.1.8.tar.gz

    # openssl can be downloaded here :
    wget https://www.openssl.org/source/openssl-1.1.1d.tar.gz

    # jpeg can be downloaded here :
    wget http://www.ijg.org/files/jpegsrc.v9d.tar.gz

    # jasper can be downloaded here :
    wget https://www.ece.uvic.ca/~frodo/jasper/software/jasper-2.0.14.tar.gz

    # eccodes can be downloaded here :
    wget https://confluence.ecmwf.int/download/attachments/45757960/eccodes-2.16.0-Source.tar.gz?api=v2

    #  grib2 can be downloaded here :
    wget https://www.nco.ncep.noaa.gov/pmb/codes/GRIB2/g2clib-1.6.0.tar

    # cdo can be downloaded here :
    # https://code.mpimet.mpg.de/projects/cdo/files
    wget https://code.mpimet.mpg.de/attachments/download/18264/cdo-1.9.5.tar.gz

    # ncl can be downloaded here :
    wget https://www.earthsystemgrid.org/dataset/ncl.662.src/file/ncl_ncarg-6.6.2.tar.gz

    cd -

