#!/bin/bash
#SBATCH --chdir=./
#SBATCH --job-name=reformat
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

#Run reformat from bbmap suite
/lustre/work/jmanthey/bbmap/reformat.sh in=${workdir}/01_blochDNA/${basename_array}_2_modoc.fastq.gz out1=${workdir}/01_blochDNA/${basename_array}_R1.fastq.gz out2=${workdir}/01_blochDNA/${basename_array}_R2.fastq.gz

#Remove unneccesary fastq files
cd /lustre/scratch/brameado/Blochmannia_Local_Adaptation/01_blochDNA
rm *_R1.fastq.gz
rm *_R2.fastq.gz
