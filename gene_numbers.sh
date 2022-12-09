# testing relationships
# extract CDS and protein
reference=Pieris_napi-GCA_905231885.1-softmasked.fa
gff_file=Pieris_napi_brakerProt_rename_agat.gff

root=Pnap.GCA_905231885.1-softmasked.brakerProt_rename_agat



# -J flag (I believe) only prints converted amino acid sequence of any mRNAs with no in exon stop codons, and with existing start and stop codon.
/data/programs/cufflinks-2.2.1.Linux_x86_64/gffread "$gff_file" -g "$reference" -J -x "$root".cds.fa -y "$root".prot.fa

# and without -J filter
/data/programs/cufflinks-2.2.1.Linux_x86_64/gffread "$gff_file" -g "$reference" -x "$root".cds.noJ.fa -y "$root".prot.noJ.fa

grep -c '>' *.fa
Pieris_napi-GCA_905231885.1-softmasked.fa:48
Pnap.GCA_905231885.1-softmasked.brakerProt_rename_agat.cds.fa:17853
Pnap.GCA_905231885.1-softmasked.brakerProt_rename_agat.cds.noJ.fa:17853
Pnap.GCA_905231885.1-softmasked.brakerProt_rename_agat.prot.fa:17853
Pnap.GCA_905231885.1-softmasked.brakerProt_rename_agat.prot.noJ.fa:17853


#

conda create --name agatenv -c bioconda agat
conda activate agatenv
agat_sp_statistics.pl --gff Pieris_napi_brakerProt_rename_agat.gff > agat_sp_statistics.out

tail -n20 agat_sp_statistics.out

Re-compute transcript without isoforms asked. We remove shortest isoforms if any

Number of gene                               16449
Number of transcript                         16964
Number gene overlapping                      0
Number of single exon gene                   16449
mean transcripts per gene                    1.0
Total gene length                            110481963
Total transcript length                      114200252
mean gene length                             6716
mean transcript length                       6731
Longest gene                                 116077
Longest transcript                           116077
Shortest gene                                173
Shortest transcript                          173

--------------------------------------------------------------------------------
