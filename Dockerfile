FROM ubuntu:latest
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
MAINTAINER Chris Plaisier <plaisier@asu.edu>
RUN apt-get update

# Get add-apt-repository function
RUN apt-get install --yes software-properties-common

# Ensure the latest version of R is installed
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 51716619E084DAB9
RUN add-apt-repository "deb [trusted=yes] https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/"
RUN apt-get update

# Fix issue with install wanting to be interactive
ENV DEBIAN_FRONTEND=noninteractive

# Instal main dependencies
RUN apt-get install --yes \
 build-essential \
 gcc-multilib \
 apt-utils \
 zlib1g-dev \
 vim-common \
 wget \
 python3 \
 python3-pip \
 git \
 pigz \
 r-base \
 r-base-dev \
 libhdf5-dev \
 libxml2-dev

# Install additional python packages using pip3
RUN pip3 install \
    numpy \
    scipy \
    cython \
    numba \
    matplotlib \
    seaborn \
    scikit-learn \
    h5py \
    click \
    pandas \
    biopython

# Install velocyto
RUN pip3 install scanpy

# Install velocyto
RUN pip3 install velocyto

# Install scvelo
RUN pip3 install scvelo

# Install Seurat
RUN R -e "install.packages(c('Seurat','ranger','plyr','dplyr','Matrix'))"

# Install loomR to convert Seurat to loom files
RUN R -e "install.packages('devtools')"
RUN R -e "devtools::install_github('hhoeflin/hdf5r')"
RUN R -e "devtools::install_github('mojaveazure/loomR', ref = 'develop')"

