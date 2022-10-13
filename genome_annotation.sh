# here we are goint to try and setup and annotation run on UPPMAX for Marina to run with

#

# files that we used
scp chrwhe@miles.zoologi.su.se:/mnt/griffin/Pierinae_genomes/Pieris_napi/Pieris_napi_Darwin_ToL/Pieris_napi-GCA_905231885.1-softmasked.fa .




######################################
#### Braker2 annotation: Polished ####
######################################
cd $PM_ANNOT
mkdir braker2_polished
# We recommend to use a relevant portion of OrthoDB protein database as the source of reference protein sequences.
# For example, if your genome of interest is an insect, download arthropoda proteins:
wget https://v100.orthodb.org/download/odb10_arthropoda_fasta.tar.gz
tar xvf odb10_arthropoda_fasta.tar.gz
cat arthropoda/Rawdata/* > odb10_arthropoda_proteins.fa

# bring in a softmasked genome that is ready for annotation, via a soft link
ln -s $PM_REF/faDnaPolishing/masking/Pmac000.1_polished.cleaned.softmasked.fa
###########
# define your genome and protein sets.
genome=Pmac000.1_polished.cleaned.softmasked.fa
proteins=odb10_arthropoda_proteins.fa


###########
# you should be able to copy and paste that below, from 'your_working_dir=$(pwd)' down to 'braker.pl ...'
# and run braker
###########

# first this makes an augustus config file in your local folder that augustus needs to be able to write to
your_working_dir=$(pwd)
cp -r /data/programs/Augustus_v3.3.3/config/ $your_working_dir/augustus_config
export AUGUSTUS_CONFIG_PATH=$your_working_dir/augustus_config


# now set paths to the other tools
export PATH=/mnt/griffin/chrwhe/software/BRAKER2_v2.1.5/scripts/:$PATH
export AUGUSTUS_BIN_PATH=/data/programs/Augustus_v3.3.3/bin
export AUGUSTUS_SCRIPTS_PATH=/data/programs/Augustus_v3.3.3/scripts
export DIAMOND_PATH=/data/programs/diamond_v0.9.24/
export GENEMARK_PATH=/data/programs/gmes_linux_64.4.61_lic/
export BAMTOOLS_PATH=/data/programs/bamtools-2.5.1/bin/
export PROTHINT_PATH=/data/programs/ProtHint/bin/
export ALIGNMENT_TOOL_PATH=/data/programs/gth-1.7.0-Linux_x86_64-64bit/bin
export SAMTOOLS_PATH=/data/programs/samtools-1.10/
export MAKEHUB_PATH=/data/programs/MakeHub/

braker.pl --genome=$genome --prot_seq=$proteins --softmasking --cores=30
# options


# Uppamx
# needed to clean up my root directory.
ssh chriw@rackham.uppmax.uu.se
# Sperling_Papillio7keynote

/home/chriw/private/braker2_testing
module load bioinfo-tools
module load braker

# and this runs it!
braker.pl

#
DESCRIPTION

braker.pl   Pipeline for predicting genes with GeneMark-EX and AUGUSTUS with
            RNA-Seq and/or proteins

SYNOPSIS

braker.pl [OPTIONS] --genome=genome.fa {--bam=rnaseq.bam | --prot_seq=prot.fa}

INPUT FILE OPTIONS

--genome=genome.fa                  fasta file with DNA sequences
--bam=rnaseq.bam                    bam file with spliced alignments from
                                    RNA-Seq
--prot_seq=prot.fa                  A protein sequence file in multi-fasta
                                    format used to generate protein hints.
                                    Unless otherwise specified, braker.pl will
                                    run in "EP mode" which uses ProtHint to
                                    generate protein hints and GeneMark-EP+ to
                                    train AUGUSTUS.
--hints=hints.gff                   Alternatively to calling braker.pl with a



######################################################
######################################################
# final steps
######################################################
######################################################

# log into Uppmax account
# go to your local folder and setup getting ready for things
#
module load bioinfo-tools
module load braker

# upload the genome, note that it is soft masked
scp chrwhe@miles.zoologi.su.se:/mnt/griffin/Pierinae_genomes/Pieris_napi/Pieris_napi_Darwin_ToL/Pieris_napi-GCA_905231885.1-softmasked.fa .
# copy to Marinas folder /proj/snic2022-22-447

# upload the proteins used for annotation
# For example, if your genome of interest is an insect, download arthropoda proteins:
wget https://v100.orthodb.org/download/odb10_arthropoda_fasta.tar.gz
tar xvf odb10_arthropoda_fasta.tar.gz
cat arthropoda/Rawdata/* > odb10_arthropoda_proteins.fa

# input files for the braker annotation run
genome=Pieris_napi-GCA_905231885.1-softmasked.fa
proteins=odb10_arthropoda_proteins.fa
# run it
braker.pl --genome=$genome --prot_seq=$proteins --softmasking --cores=1

# got error
# AUGUSTUS_CONFIG_PATH/species (in this case /sw/bioinfo/augustus/3.4.0/rackham/config/) is not writeable.

# this was warned about during module load
module load braker
# augustus/3.4.0 : If you see errors about not being able to write to an augustus directory, see 'module help augustus/3.4.0'
# so run this to make a local dir for the config
source $AUGUSTUS_CONFIG_COPY
# returns
# Copying Augustus config directory to current directory...adjusting permissions...updating AUGUSTUS_CONFIG_PATH...done
# export AUGUSTUS_CONFIG_PATH=/home/chriw/private/braker2_testing/augustus_config

# Thu Oct 13 13:40:55 2022: Log information is stored in file /domus/h1/chriw/private/braker2_testing/braker/braker.log
#*********
# WARNING: Detected whitespace in fasta header of file /domus/h1/chriw/private/braker2_testing/Pieris_napi-GCA_905231885.1-softmasked.fa. This may later on cause problems! The pipeline will create a new file without spaces or "|" characters and a genome_header.map file to look up the old and new headers. This message will be suppressed from now on!
#*********
ERROR in file /sw/bioinfo/braker/2.1.6/rackham/scripts/braker.pl at line 6586
Failed to execute: perl /sw/bioinfo/GeneMark/4.68-es/rackham/gmes_petap.pl --verbose --cores=1 --ES --gc_donor 0.001 --sequence=/domus/h1/chriw/private/braker2_testing/braker/genome.fa  --soft_mask auto 1>/domus/h1/chriw/private/braker2_testing/braker/GeneMark-ES.stdout 2>/domus/h1/chriw/private/braker2_testing/braker/errors/GeneMark-ES.stderr
The most common problem is an expired or not present file ~/.gm_key!
# GeneMark/4.68-es : A recent key file is needed to use this software and it must exist in your home directory. See 'module help GeneMark/4.68-es'
cp -vf /sw/bioinfo/GeneMark/keyfile/gm_key $HOME/.gm_key


######################################################
# final steps
######################################################

# setup
module load bioinfo-tools
module load braker
source $AUGUSTUS_CONFIG_COPY
cp -vf /sw/bioinfo/GeneMark/keyfile/gm_key $HOME/.gm_key

# upload the proteins used for annotation
# For example, if your genome of interest is an insect, download arthropoda proteins:
wget https://v100.orthodb.org/download/odb10_arthropoda_fasta.tar.gz
tar xvf odb10_arthropoda_fasta.tar.gz
cat arthropoda/Rawdata/* > odb10_arthropoda_proteins.fa

# get genome into this folder
genome=Pieris_napi-GCA_905231885.1-softmasked.fa
proteins=odb10_arthropoda_proteins.fa

# run
braker.pl --genome=$genome --prot_seq=$proteins --softmasking --cores=1


# but of course you ened to be able to run this using many cores, so that it is mor efficient
# to do this you need to write a file to put your run into the que of runs, so the software
# can efficiently, and dynamically allocate jobs to resources, for all the 100's of users of Rackam

################
# SLURM
################
https://www.uppmax.uu.se/support/user-guides/rackham-user-guide/

# jobs I have, and what is wainting to run
jobinfo -u chriw
squeue -u chriw


# write the slurm file
nano braker20_test.slurm

#!/bin/bash -l
#SBATCH -A snic2022-22-447
#SBATCH -p core -n 19
#SBATCH -t 00:10:00
#SBATCH -J braker20
module load bioinfo-tools
module load braker
source $AUGUSTUS_CONFIG_COPY
braker.pl --genome=Pieris_napi-GCA_905231885.1-softmasked.fa --prot_seq=odb10_arthropoda_proteins.fa --softmasking --cores=19

# send it to the manager to run
sbatch braker20_test.slurm

# where am I in the waiting line?
squeue -u chriw
