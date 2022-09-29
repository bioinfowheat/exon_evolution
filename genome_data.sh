# just had good talk with Marina about how to go about generating a novel dataset


# need dataset that has solid genome and simplified annotation

# going to be using the P. napi geomes from the Darwin Tree of Life
# for which we have generated a new annotation using only the Arthropod protein set via Braker2

Pieris_napi-GCA_905231885.1-softmasked.fa

# RS annotation of the DToL genome
# Braker protein based annotation renamed with tsebra reformatted with agat.
# /mnt/griffin/racste/P_napi/refs/braker2/merge_annot/Pieris_napi_brakerProt_rename_agat.gff
Pieris_napi_brakerProt_rename_agat.gff


# local directory testing
cd /mnt/griffin/chrwhe/exon_evolution
ln -s /mnt/griffin/Pierinae_genomes/Pieris_napi/Pieris_napi_Darwin_ToL/Pieris_napi-GCA_905231885.1-softmasked.fa .
ln -s /mnt/griffin/chrwhe/miRNA/Pieris_napi_brakerProt_rename_agat.gff .


# testing relationships
# extract CDS and protein
reference=Pieris_napi-GCA_905231885.1-softmasked.fa
gff_file=Pieris_napi_brakerProt_rename_agat.gff
root=Pnap.GCA_905231885.1-softmasked.brakerProt_rename_agat
# -J flag (I believe) only prints converted amino acid sequence of any mRNAs with no in exon stop codons, and with existing start and stop codon.
/data/programs/cufflinks-2.2.1.Linux_x86_64/gffread "$gff_file" -g "$reference" -J -x "$root".cds.fa -y "$root".prot.fa

# and without -J filter
/data/programs/cufflinks-2.2.1.Linux_x86_64/gffread "$gff_file" -g "$reference" -J -x "$root".cds.noJ.fa -y "$root".prot.noJ.fa

grep -c '>' *.fa
Pieris_napi-GCA_905231885.1-softmasked.fa:48
Pnap.GCA_905231885.1-softmasked.brakerProt_rename_agat.cds.fa:17853
Pnap.GCA_905231885.1-softmasked.brakerProt_rename_agat.cds.noJ.fa:17853
Pnap.GCA_905231885.1-softmasked.brakerProt_rename_agat.prot.fa:17853
Pnap.GCA_905231885.1-softmasked.brakerProt_rename_agat.prot.noJ.fa:17853

# compress for sharing
cat Pieris_napi_brakerProt_rename_agat.gff | gzip > Pieris_napi_brakerProt_rename_agat.gff.gz
cat Pieris_napi-GCA_905231885.1-softmasked.fa | gzip > Pieris_napi-GCA_905231885.1-softmasked.fa.gz
pigz Pnap.GCA_905231885.1-softmasked.brakerProt_rename_agat.cds.fa
pigz Pnap.GCA_905231885.1-softmasked.brakerProt_rename_agat.prot.fa
# transfer
scp chrwhe@miles.zoologi.su.se:/mnt/griffin/chrwhe/exon_evolution/\*gz .
