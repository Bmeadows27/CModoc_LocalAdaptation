#!/bin/bash
#SBATCH --chdir=./
#SBATCH --job-name=bam
#SBATCH --partition quanah
#SBATCH --nodes=1 --ntasks=12
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=8G
#SBATCH --array=1-42

module load intel java bwa samtools singularity

export SINGULARITY_CACHEDIR="/lustre/work/brameado/singularity-cachedir"

# define main working directory
workdir=/lustre/scratch/brameado/Blochmannia_Local_Adaptation

basename_array=$( head -n${SLURM_ARRAY_TASK_ID} ${workdir}/basenames.txt | tail -n1 )

# define the reference genome
refgenome=/lustre/scratch/brameado/Camponotus_Local_Adaptation/camp_sp_genome_filtered.fasta

# define the location of the reference mitogenomes
bloch=/lustre/scratch/brameado/Blochmannia_Local_Adaptation/2_modoc.fasta

# run bbduk
/lustre/work/jmanthey/bbmap/bbduk.sh in1=${workdir}/00_fastq/${basename_array}_R1.fastq.gz in2=${workdir}/00_fastq/${basename_array}_R2.fastq.gz out1=${workdir}/01_cleaned/${basename_array}_R1.fastq.gz out2=${workdir}/01_cleaned/${basename_array}_R2.fastq.gz minlen=50 ftl=10 qtrim=rl trimq=10 ktrim=r k=25 mink=7 ref=/lustre/work/jmanthey/bbmap/resources/adapters.fa hdist=1 tbo tpe

#run bbsplit
/lustre/work/jmanthey/bbmap/bbsplit.sh in1=${workdir}/01_cleaned/${basename_array}_R1.fastq.gz in2=${workdir}/01_cleaned/${basename_array}_R2.fastq.gz ref=${bloch} basename=${workdir}/01_blochDNA/${basename_array}_%.fastq.gz outu1=${workdir}/01_blochDNA/${basename_array}_R1.fastq.gz outu2=${workdir}/01_blochDNA/${basename_array}_R2.fastq.gz
