#!/bin/sh

# requirement :
# miniconda3

# ensure that conda default repository are setup
conda config --add channels conda-forge
conda config --add channels defaults
conda config --add channels r
conda config --add channels bioconda

# create conda env
conda create --name bioinfo

# activate virtual env
source activate bioinfo

# install appli
conda install samtools
conda install gatk
conda install bwa
conda install fastqc
conda install snpeff