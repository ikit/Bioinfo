#!/bin/sh

CONDA_PATH="$HOME/bin/miniconda3"
BIOINFO_PATH="$HOME/bioinfo"
BIOREF_PATH="$HOME/bioinfo/ref"
BIOBIN_PATH="$HOME/bioinfo/bin"

mkdir -p $BIOINFO_PATH
mkdir -p $BIOBIN_PATH
mkdir -p $BIOREF_PATH
cd BIOINFO_PATH


# Some bioinfo Tools that are not in conda repo
cd $BIOBIN_PATH
wget http://hgdownload.cse.ucsc.edu/admin/exe/linux.x86_64/twoBitToFa
chmod +x twoBitToFa










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
conda install snakemake
conda install samtools
conda install gatk
conda install bwa
conda install fastqc
conda install snpeff
conda install pullseq
conda install bedtools
conda install picard
conda install bcftools
conda install seqtk             # Adding mutation in fasta file




# Prepare ref data
cd $BIOREF_PATH
# download hg19, hg38 2bit 
wget http://hgdownload.cse.ucsc.edu/goldenPath/hg19/bigZips/hg19.2bit
wget http://hgdownload.cse.ucsc.edu/goldenPath/hg38/bigZips/hg38.2bit
# Convert 2bit to fasta
twoBitToFa hg19.2bit hg19.fa
twoBitToFa hg38.2bit hg38.fa
# Create clean version of reference without "bad chromosomes"
pullseq -i hg19.fa -g "chr[1-9XYM]{1,2}$" > hg19.clean.fa
pullseq -i hg38.fa -g "chr[1-9XYM]{1,2}$" > hg38.clean.fa
# Create indexes
samtools faidx hg19.fa
bwa index hg19.fa
samtools faidx hg19.clean.fa
bwa index hg19.clean.fa
samtools faidx hg38.fa
bwa index hg38.fa
samtools faidx hg38.clean.fa
bwa index hg38.clean.fa


