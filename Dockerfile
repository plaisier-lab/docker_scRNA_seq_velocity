FROM ubuntu:latest
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
MAINTAINER Chris Plaisier <plaisier@asu.edu>
RUN apt-get update

ENV DEBIAN_FRONTEND=noninteractive

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
pip install scanpy

# Install velocyto
pip install velocyto

# Install scvelo
pip install scvelo

# Install Seurat
RUN R -e "install.packages(c('Seurat','ranger','plyr','dplyr','Matrix'))"

# Install loomR to convert Seurat to loom files
RUN R -e "install.packages('devtools')"
RUN R -e "devtools::install_github('hhoeflin/hdf5r')"
RUN R -e "devtools::install_github('mojaveazure/loomR', ref = 'develop')"

