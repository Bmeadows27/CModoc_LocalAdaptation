#!/bin/sh
#SBATCH --chdir=./
#SBATCH --job-name=filter
#SBATCH --nodes=1 --ntasks=1
#SBATCH --partition quanah
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=8G
#SBATCH --array=1-1

module load intel vcftools bcftools

# define input files from helper file during genotyping
input_array=$( head -n${SLURM_ARRAY_TASK_ID} helper6.txt | tail -n1 )

# define main working directory
workdir=/lustre/scratch/brameado/Blochmannia_Local_Adaptation

# run vcftools with SNP output for ADMIXTURE 
vcftools --vcf ${workdir}/03_vcf/${input_array}.g.vcf  --remove-indv B015 --remove-indv B104 --remove-indv B246 --max-missing 1.0 --minQ 20 --minGQ 20 --minDP 10 --min-alleles 2 --max-alleles 2 --maf 0.05 --remove-indels --recode --recode-INFO-all --out ${workdir}/04_filter_vcf_admixture/${input_array}

#run vcftools with SNP output for GEA tests
vcftools --vcf ${workdir}/03_vcf/${input_array}.g.vcf  --remove-indv B015 --remove-indv B104 --remove-indv B246 --max-missing 0.8 --minQ 20 --minGQ 20 --minDP 10 --min-alleles 2 --max-alleles 2 --maf 0.05 --remove-indels --recode --recode-INFO-all --out ${workdir}/05_filter_vcf_GEA/${input_array}

# run bcftools to simplify the vcftools output for ADMIXTURE
bcftools query -f '%CHROM\t%POS\t%REF\t%ALT[\t%GT]\n ' ${workdir}/04_filter_vcf_admixture/${input_array}.recode.vcf > ${workdir}/04_filter_vcf_admixture/${input_array}.simple.vcf

# run bcftools to simplify the vcftools output for GEA
bcftools query -f '%CHROM\t%POS\t%REF\t%ALT[\t%GT]\n ' ${workdir}/06_filter_vcf_GEA/${input_array}.recode.vcf > ${workdir}/05_filter_vcf_GEA/${input_array}.simple.vcf
