

# Installing ART tool for data generation


wget https://www.niehs.nih.gov/research/resources/assets/docs/artbinmountrainier20160605linux64tgz.tgz
tar -xvf artbinmountrainier20160605linux64tgz.tgz
ln -s ../apps/art_bin_MountRainier/art_illumina .


wget http://hgdownload.cse.ucsc.edu/goldenpath/hg19/database/refGene.txt.gz



# Generate Panel
GENES="SPINK1|GJB2|CRTC|BIRC6"
REF_PATH="/bioinfo/data/reference/hg19.clean.fa"

# Create bed file with gene region
zcat refGene.txt.gz |grep -E "$GENES"|awk 'BEGIN{OFS="\t"}{print $3,$5,$6}' > panel.bed
# Mergin region that overlap (because of several transcript by gene)
bedtools sort -i panel.bed  > panel.sort.bed
bedtools merge -i panel.sort.bed  > final.bed
# Get fasta from ref 
bedtools getfasta  -fi $REF_PATH -bed final.bed -fo panel.fa


art_illumina -ss HSXt -amp -p -sam -na -i panel.fa -l 150 -f 100 -o amplicon_pair_dat